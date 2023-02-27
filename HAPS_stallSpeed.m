function V = HAPS_stallSpeed(altitude, m0)
% Calculate the stall speed of the HAPS aircraft at a given weight and
% altitude
g = 9.80665;
rho = atmosDensity(altitude);
AR = 30;
CD0 = 0.02;
e = 0.8;
k = 1 / (pi*e*AR);
Cl_max = 1.7;
S = 58.8;
V = sqrt(2 * m0 * g / (rho * S * Cl_max));