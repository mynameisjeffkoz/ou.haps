function P = HAPS_SLUFPower(alt, m0,S)
% Calculate the usable power requirement for SLUF at a given altitude and weight
g = 9.80665;
AR = 30;
CD0 = 0.02;
e = 0.8;
k = 1 / (pi*e*AR);
rho = atmosDensity(alt);
V = 1.15 * HAPS_stallSpeed(alt, m0,S);
q = 0.5 * rho * V^2;
CL = m0 * g / (q * S);
CD =  CD0 + k * CL^2;
D = q * S * CD;
P = D * V;
