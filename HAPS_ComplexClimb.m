function h = HAPS_ComplexClimb(alt, w0, PA, t)
% Calculate the altitude that the HAPS can gain with a certain total power
% available, at a given height, in a period of time
g = 9.80665;
PR_min = HAPS_FlightPower("SLUF",alt,w0);
P_net = PA - PR_min;
Vv = P_net / (g * w0);
h = Vv * t;