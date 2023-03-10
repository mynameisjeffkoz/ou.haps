function t = HAPS_ClimbRecharge(hi, hf, capacity, state, DOD, S)
% Model the HAPS aircraft in a recharge and climb segment.
% Recharge the aircraft in cruise at 16km until the power available is
% sufficient to fully power the engines. Climb to the max altitude, then
% finish charging.

% Some starting parameters
day = 355;
lat = 20;
e_area = 1;
e_panel = 0.23;
e_batt = 0.96;

% Calculate HAPS weight
m0 = HAPS_sizing(capacity,S);

% Effective area of the panels, based on panel and packing efficiency,
% inlcuding some number of panels on the horizontal tail
eff_area = S * e_area * e_panel;

% Correct depth of discharge if entered as whole number percentage
if DOD > 1
    DOD = min(DOD/100, 1);
end

% Calculate battery capacity limits as needed
min_charge = (1-DOD)/2 * capacity;
if state < min_charge
    state = min_charge;
end
max_charge = (1+DOD)/2 * capacity;

% Calculate cruise1 power requirement
PR_cruise1 = HAPS_FlightPower("SLUF", hi, m0,S);
% Begin charging when solar can support all power requirements
t_start = HAPS_startTime(hi,m0,S);

% Find power requirement for max climb
PR_climb = HAPS_FlightPower("CLIMB", hi, m0,S);
% Get specific power for max climb
p_spec_climb = PR_climb / eff_area;
% Find the time to switch to climb
t_switch = FindGHI(p_spec_climb, day, lat, hi);

% Start calculating from t_start
t = t_start;
% while battery is not full and until t_switch
while state < max_charge & t < t_switch
    % Calculate solar power available
    P_solar = GHI(t, day, lat, hi) * eff_area;
    % Calculate the net power
    P_net = P_solar - PR_cruise1;
    % Add the net energy (Power * time * battery efficiency)
    state = state + P_net / 1000 / 60 * e_batt;
    % Step forward one minute
    t = t + 1/60;
end

% Debugging Statement
%fprintf("End of Cruise 1\nBattery State: %d\nTime: %d\n\n", state, t)

% Start tracking the current altitude
h = hi;
% Until climb is complete
while h < hf
    % Calculate solar power available
    P_solar = GHI(t, day, lat, h) * eff_area;
    % Calculate the net power
    P_net = P_solar - PR_climb;
    % Add the net energy (Power * time * battery efficiency)
    state = state + P_net / 1000 / 60 * e_batt;
    % Step forward one minute
    t = t + 1/60;
    % Track the climb of the aircraft
    h = h + HAPS_TimedClimb(h, m0, 60,S);
end

% Debugging Statement
%fprintf("End of Climb\nBattery State: %d\nTime: %d\nAltitude: %d\n", state, t, h)

% Calculate the new cruise power requirement
PR_cruise2 = HAPS_FlightPower("SLUF",hf,m0,S);

% Until the battery is full or power runs out
while state < max_charge & P_solar >= PR_cruise2
    % Calculate solar power available
    P_solar = GHI(t + 1/60, day, lat, hf) * eff_area;
    % Calculate the net power
    P_net = P_solar - PR_cruise2;
    % Add the net energy (Power * time * battery efficiency)
    state = state + P_net / 1000 / 60 * e_batt;
    % Step forward one minute
    t = t + 1/60;
end
% Correct for accidental overcharge
if (state > max_charge)
    state = max_charge;
end

% Debugging Statement
%fprintf("End of Cruise 2\nBattery State: %d\nTime: %d\n\n", state, t)

% Calculate the time at which power available is less than power draw
t_dark = LastGHI(PR_cruise2/eff_area,day,lat,hf);
% No calculations needed between these two times
t = t_dark - t_start;

% Check for program failure case
if state < max_charge
    fprintf("Cycle failure: Battery reached only %d / %d", state, max_charge)
    t = 0;
end

