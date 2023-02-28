function Vv = HAPS_sinkRate(altitude, m0,S)
% Calculate the sink rate of the unpowered HAPS aircraft at the given
% altitude and weight
g = 9.80665;
AR = 30;
CD0 = 0.02;
e = 0.8;
k = 1 / (pi*e*AR);
Cl_max = 1.7;
rho = atmosDensity(altitude);
V = 1.2 * HAPS_stallSpeed(altitude, m0,S);
q = 0.5 * rho * V^2;
CL = m0 * g / (q * S);
CD =  CD0 + k * CL^2;
Vv = sqrt(m0 * g/S * 2/rho * CD^2/CL^3);