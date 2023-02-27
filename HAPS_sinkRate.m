function Vv = HAPS_sinkRate(altitude, w0)
% Calculate the sink rate of the unpowered HAPS aircraft at the given
% altitude and weight
g = 9.80665;
AR = 30;
CD0 = 0.02;
e = 0.8;
k = 1 / (pi*e*AR);
Cl_max = 1.7;
S = 58.8;
rho = atmosDensity(altitude);
V = 1.2 * HAPS_stallSpeed(altitude, w0);
q = 0.5 * rho * V^2;
CL = w0 / (q * S);
CD =  CD0 + k * CL^2;
Vv = sqrt(w0/S * 2/rho * CD^2/CL^3);