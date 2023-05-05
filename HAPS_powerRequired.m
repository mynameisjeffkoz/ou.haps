function P = HAPS_powerRequired(m0,S,V,h)
% Calculate the power requirement for the HAPS aircraft at a given velocity
% and altitude


% Some variables necessary to complete the calculation
g = 9.80665;
AR = 30;
CD0 = 0.02;
e = 0.8;
k = 1 / (pi*e*AR);
% Get the air density;
rho = atmosDensity(h);

% Calculate the aircraft weight
W = m0 * g;


% Calculate the power requirement
P = 1/2 * rho * V^3 * S * CD0 + 2 / (rho * V * S) * W^2 * k;