function t_total = HAPS_FlightCycle(h_min, h_max, capacity, DOD, S)
% Calculate the total length of time of a flight cycle for the HAPS
% aircraft. Starting from when the panels first receive enough power to
% run the aircraft and no charge saved, through recharge and climb,
% descent, and cruise until all power is exhausted.
day = 355;
lat = 20;
e_batt = 0.96;
m0 = HAPS_sizing(capacity,S);
if DOD > 1
    DOD = DOD / 100;
end
min_charge = (1-DOD)/2 * capacity;
max_charge = (1+DOD)/2 * capacity;

% Calculate the start time of the flight cycle (the first point at which
% the aircraft can be fully powered by solar)
t_start = HAPS_startTime(h_min, m0,S);

% Calculate the length of the Climb/Recharge/Cruise segment
t_charge = HAPS_ClimbRecharge(h_min,h_max,capacity,min_charge,DOD,S);

% Calculate the time at which solar power is no longer sufficient to fully
% power the aircraft
t_switch = t_start + t_charge;
[t_sunset, E_sunset, dh] = HAPS_sunset(h_max, m0, S, t_switch);
t_sunset;

% Calculate the length of the glide segment in hours, accounting for
% altitude already lost
t_glide = HAPS_glideTime(h_max - dh,h_min,m0,S) / 3600;

% Calculate the state of the battery after glide, accounting for altitude
% already lost
E_batt = max_charge - E_sunset - ...
         HAPS_DescentPower(h_max - dh,h_min,capacity,S) / e_batt;

% Calculate the length of the dark cruise segment
t_cruise = HAPS_CruiseEndurance(h_min,capacity,E_batt,DOD,S);

% Calculate the total length of time of all flight segments
t_total = t_charge + t_sunset + t_glide + t_cruise;

% If the total time is less than 24 hours
if t_total < 24
    % Find the next sunrise
    t_nextSun = solar_sunrise(day + 1,lat);
    % Convert to minutes
    t_nextSun = t_nextSun * 60;
    % Round up to an even minute, then go back to hours
    t_nextSun = ceil(t_nextSun) / 60;
    % Find the overlap between the next sunrise and the current flight
    % cycle
    t_over = t_start + t_total - (t_nextSun + 24);
    % If the overlap is positive
    if (t_over > 0)
        % Update the total time to last until sunrise
        t_total = (t_nextSun + 24) - t_start;
        % Calculate the new cruise time
        t_cruise = t_cruise - t_over;
        % Calculate the battery state after the new cruise time
        E_batt = E_batt - HAPS_CruiseForDuration(t_cruise,h_min,capacity,S);
        % Calculate how long the aircraft can maintain flight
        t_morning = HAPS_morningFlight(day + 1, lat, h_min, E_batt,...
            capacity, DOD, S);
        t_total = t_total + t_morning;
    end
end


