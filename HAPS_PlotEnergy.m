function HAPS_PlotEnergy(h_min, h_max, capacity, DOD, S)
% Plot the battery percentage over the course of a flight cycle
%% Starting Parameters
day = 355;
lat = 20;
e_area = 1;
e_panel = 0.23;
eff_area = S * e_area * e_panel;
e_batt = 0.96;
m0 = HAPS_sizing(capacity,S);

battery_plot = zeros(size(0:1/60:24));
altitude_plot = zeros(size(0:1/60:24));
i = 1;
% Correct depth of discharge if entered as whole number percentage
if DOD > 1
    DOD = min(DOD/100, 1);
end

% Calculate battery capacity limits as needed
min_charge = (1-DOD)/2 * capacity;
max_charge = (1+DOD)/2 * capacity;

%% Climb Recharge

h = h_min;
state = min_charge;
battery_plot(i) = state / capacity;
altitude_plot(i) = h;
t_full = 0;

% Calculate cruise1 power requirement
PR_cruise1 = HAPS_FlightPower("SLUF", h_min, m0,S);
% Begin charging when solar can support all power requirements
t_start = HAPS_startTime(h_min,m0,S);

% Find power requirement for max climb
PR_climb = HAPS_FlightPower("CLIMB", h_min, m0,S);
% Get specific power for max climb
p_spec_climb = PR_climb / eff_area;
% Find the time to switch to climb
t_switch = FindGHI(p_spec_climb, day, lat, h_min);

% Start calculating from t_start
t = t_start;
% while battery is not full and until t_switch
while state < max_charge & t < t_switch
    % Calculate solar power available
    P_solar = GHI(t, day, lat, h_min) * eff_area;
    % Calculate the net power
    P_net = P_solar - PR_cruise1;
    % Add the net energy (Power * time * battery efficiency)
    state = state + P_net / 1000 / 60 * e_batt;
    % Step forward one minute
    t = t + 1/60;
    % Increment the plot counter
    i = i + 1;
    % Set the battery plot
    percent = state / capacity;
    battery_plot(i) = percent;
    altitude_plot(i) = h;
end

% Debugging Statement
%fprintf("End of Cruise 1\nBattery State: %d\nTime: %d\n\n", state, t)

% Start tracking the current altitude
h = h_min;
% Until climb is complete
while h < h_max
    % Calculate solar power available
    P_solar = GHI(t, day, lat, h) * eff_area;
    % Calculate the net power
    P_net = P_solar - PR_climb;
    % Add the net energy (Power * time * battery efficiency)
    state = state + P_net / 1000 / 60 * e_batt;
    % Step forward one minute
    t = t + 1/60;
    % Increment the plot counter
    i = i + 1;
    % Set the battery plot
    percent = state / capacity;
    battery_plot(i) = min(percent,(DOD+1)/2);
    % Track the climb of the aircraft
    h = h + HAPS_TimedClimb(h, m0, 60,S);
    altitude_plot(i) = min(h,h_max);
end

if (battery_plot(i) == (DOD+1)/2)
    t_full = t;
end

% Correct for over altitude
if h > h_max
    h = h_max;
end

% Debugging Statement
%fprintf("End of Climb\nBattery State: %d\nTime: %d\nAltitude: %d\n", state, t, h)

% Calculate the new cruise power requirement
PR_cruise2 = HAPS_FlightPower("SLUF",h_max,m0,S);

% Until the battery is full or power runs out
while state < max_charge & P_solar >= PR_cruise2
    % Calculate solar power available
    P_solar = GHI(t + 1/60, day, lat, h_max) * eff_area;
    % Calculate the net power
    P_net = P_solar - PR_cruise2;
    % Add the net energy (Power * time * battery efficiency)
    state = state + P_net / 1000 / 60 * e_batt;
    % Step forward one minute
    t = t + 1/60;
    % Increment the plot counter
    i = i + 1;
    % Set the battery plot
    percent = state / capacity;
    battery_plot(i) = min(percent, (DOD+1)/2);
    if (battery_plot(i) == (DOD+1)/2 && t_full == 0)
        t_full = t;
    end
    altitude_plot(i) = h;
end
% Correct for accidental overcharge
if (state > max_charge)
    state = max_charge;
end

% Debugging Statement
%fprintf("End of Cruise 2\nBattery State: %d\nTime: %d\n\n", state, t)

% Calculate the time at which power available is less than power draw
t_dark = LastGHI(PR_cruise2/eff_area,day,lat,h_max);
% No calculations needed between these two times
t = t_dark;

i_dark = round((t_dark - t_full) * 60) + i;
for i = i:i_dark
    battery_plot(i) = (1+DOD)/2;
    altitude_plot(i) = h;
end
%% Sunset
dh = 0;
E = 0;
alt = h_max;
% Phase 1: Full Power glide
% For as long as the aircraft is fully powered, run the systems entirely
% off of solar

% Calculate power draw
PR = HAPS_FlightPower("GLIDE",alt,m0,S);
% Calculate power target
GHI_tgt = PR / eff_area;
% For as long as GHI is above the target
while (GHI(t+1/60,day,lat, alt-dh) > GHI_tgt)
    % No energy usage
    % Calculate sink rate
    Vv = HAPS_sinkRate(alt-dh,m0,S);
    % Add sink to the altitude change
    dh = dh + Vv * 60;
    % Tick forward
    t = t + 1/60;
    % Increment the plot counter
    i = i + 1;
    % Set the battery plot
    percent = state / capacity;
    battery_plot(i) = min(percent, (DOD+1)/2);
    altitude_plot(i) = alt-dh;
end
% Phase 2: Partial Power glide
% For as long as the aircraft gets some power, keep taking on power
while (GHI(t+1/60,day,lat, alt-dh) > 0)
    % Calculate the net power
    P_net = PR - GHI(t+1/60,day,lat,alt-dh) * eff_area;
    % Calculate the energy used
    E = E + P_net / 1000 / 60 / e_batt;
    % Calculate sink rate
    Vv = HAPS_sinkRate(alt-dh,m0,S);
    % Add sink to the altitude change
    dh = dh + Vv * 60;
    % Tick time forwards
    t = t + 1/60;
    % Increment the plot counter
    i = i + 1;
    % Set the battery plot
    state = state - P_net / 1000 / 60 / e_batt;
    percent = state / capacity;
    battery_plot(i) = min(percent, (DOD+1)/2);
    altitude_plot(i) = alt-dh;
end
h = h_max - dh;
%% Glide
% Find the glide time in minutes
t_glide = round(HAPS_glideTime(h,h_min,m0,S) / 60);
% Find the number of steps to glide for
i_glide = (t_glide) + i;
for i = i:i_glide
    % Calculate the decrease in battery state
    state = state - PR / 60 / 1000 / e_batt;
    percent = state / capacity;
    battery_plot(i) = percent;
    % Calculate the loss in altitude
    Vv = HAPS_sinkRate(h, m0, S);
    h = h - Vv * 60;
    altitude_plot(i) = h;
end
% Update the global time counter
t = t + t_glide / 60;
%% Cruise to midnight
PR = HAPS_FlightPower("SLUF", h_min, m0, S);
while t < 24
    state = state - PR / 1000 / 60 / e_batt;
    i = i + 1;
    percent = state / capacity;
    battery_plot(i) = percent;
    altitude_plot(i) = h_min;
    t = t + 1/60;
end
%% After midnight
% It's the next day, start at 0 hrs
t = 0;
day = day + 1;
while i < (24 * 60 + 1)
    % Find the net power
    P_net = HAPS_ChargeRate(t, day, lat, alt, S) - PR;
    state = state + P_net / 60 / 1000 / e_batt;
    i = i + 1;
    percent = state / capacity;
    battery_plot(i) = percent;
    altitude_plot(i) = h_min;
    t = t + 1/60;
end
%% Plotting functions
% Convert battery from decimal to percentage
battery_plot = battery_plot * 100;
% Convert altitude from m to km
altitude_plot = altitude_plot / 1000;
clf
hold off
yyaxis left
plot(0:1/60:24,battery_plot);
xlabel('Time (h)')
xlim([0 24]);
xticks(0:4:24)
ylabel('Battery Percentage')
ylim([0 100]);
yyaxis right
plot (0:1/60:24, altitude_plot)
ylabel('Altitude (km)')
ylim([0 35]);