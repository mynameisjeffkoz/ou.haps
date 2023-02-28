function t_charge = HAPS_Recharge(alt, capacity, state, DOD, t_start)
% Calculate the time required to recharge the HAPS batteries from empty to
% full at a given altitude, max battery size, charge state, and depth of
% discharge
day = 355;
lat = 20;
S = 58.8;
e_area = 0.9;
e_panel = 0.23;
e_batt = 0.96;
w0 = HAPS_sizing(capacity,S);
eff_area = S * e_area * e_panel;
if DOD > 1
    DOD = DOD / 100;
end
max_charge = (1+DOD)/2 * capacity;
PR = HAPS_FlightPower("SLUF", alt, w0);
p_spec = PR / eff_area;
t = t_start;
while state < max_charge
    P_solar = GHI(t, day, lat, alt) * eff_area;
    P_net = P_solar - PR;
    state = state + P_net / 1000 / 60 * e_batt;
    t = t + 1/60;
end
if state > max_charge
    state = max_charge; %#ok<NASGU>
end
t_final = t;
t_charge = t_final - t_start;
    