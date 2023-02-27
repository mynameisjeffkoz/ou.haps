function t_total = HAPS_FlightCycle(h_min, h_max, capacity, DOD)
% Calculate the total length of time of a flight cycle for the HAPS
% aircraft. Starting from when the panels first receive enough power to
% run the aircraft and no charge saved, through recharge and climb,
% descent, and cruise until all power is exhausted.
day = 355;
lat = 20;
e_batt = 0.96;
w0 = HAPS_sizing(capacity);
if DOD > 1
    DOD = DOD / 100;
end
min_charge = (1-DOD)/2 * capacity;
max_charge = (1+DOD)/2 * capacity;

% Calculate the length of the Climb/Recharge/Cruise segment
t_charge = HAPS_ClimbRecharge(h_min,h_max,capacity,min_charge,DOD);

% Calculate the length of the glide segment in hours
t_glide = HAPS_glideTime(h_max,h_min,w0) / 3600;

% Calculate the state of the battery after glide
E_batt = max_charge - HAPS_DescentPower(h_max,h_min,40) / e_batt;

% Calculate the length of the dark cruise segment
t_cruise = HAPS_CruiseEndurance(h_min,40,E_batt,75);

% Calculate the total length of time of all flight segments
t_total = t_charge + t_glide + t_cruise;

