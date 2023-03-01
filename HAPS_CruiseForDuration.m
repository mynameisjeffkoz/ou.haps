function E = HAPS_CruiseForDuration(t,alt,cap,S)
% Calculate the power usage over a certain period of time in cruise, at a
% given altitude and aircraft configuration
m0 = HAPS_sizing(cap, S);
PR = HAPS_FlightPower("SLUF", alt, m0, S);
E = PR / 1000 * t;
