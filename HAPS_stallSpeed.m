function V = HAPS_stallSpeed(altitude, w0)
% Calculate the stall speed of the HAPS aircraft at a given weight and
% altitude
rho = atmosDensity(altitude);
AR = 30;
CD0 = 0.02;
e = 0.8;
k = 1 / (pi*e*AR);
Cl_max = 1.7;
S = 58.8;
V = sqrt(2 * w0 / (rho * S * Cl_max));