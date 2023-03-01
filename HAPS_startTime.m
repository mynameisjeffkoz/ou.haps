function t_start = HAPS_startTime(hi, m0, S)
%% Some starting parameters
day = 355;
lat = 20;
e_area = 0.9;
e_panel = 0.23;
eff_area = S * e_area * e_panel;
%% Calculate the start time

% Calculate cruise power requirement
PR_cruise1 = HAPS_FlightPower("SLUF", hi, m0,S);

% Specific power (irradiance) for cruise
p_spec_cruise1 = PR_cruise1 / eff_area;

% Begin charging when solar can support all power requirements
t_start = FindGHI(p_spec_cruise1, day, lat, hi);