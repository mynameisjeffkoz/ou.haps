function P = HAPS_SLUFPower(alt, w0)
% Calculate the usable power requirement for SLUF at a given altitude and weight
g = 9.80665;
AR = 30;
CD0 = 0.02;
e = 0.8;
k = 1 / (pi*e*AR);
S = 58.8;
rho = atmosDensity(alt);
V = 1.2 * HAPS_stallSpeed(alt, w0);
q = 0.5 * rho * V^2;
CL = w0 / (q * S);
CD =  CD0 + k * CL^2;
D = q * S * CD;
P = D * V;
