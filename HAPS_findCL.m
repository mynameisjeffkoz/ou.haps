function CL = HAPS_findCL(alt, cap, speed_factor, S)
% Calculate the CL at a certain percentage above stall speed
g = 9.80665;
m0 = HAPS_sizing(cap, S);
v = speed_factor * HAPS_stallSpeed(alt,m0,S);
q = 0.5 * atmosDensity(alt) * v^2;
CL = m0 * g / (q * S);