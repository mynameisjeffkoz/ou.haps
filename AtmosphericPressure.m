function P = AtmosphericPressure(h)
% Calculate the atmospheric pressure at a given altitude
g = 9.80665;
M = 0.0289644;
R = 8.3144598;
P_b = [101325 22632.1 5474.89 868302 110.91 66.94 3.96];
h_b = [0 11000 20000 32000 47000 51000 71000 100000];
T_b = [288.15 216.65 216.65 228.65 270.65 270.65 214.65];
L_b = [-.0065 0 0.001 0.0028 0 -0.0028 -0.002];
for i = 1:(length(h_b) - 1)
    if h >= h_b(i) & h < h_b(i + 1)
        break
    end
end
if L_b(i) ~= 0
    P = P_b(i) * ((T_b(i) + (h - h_b(i)) * L_b(i)) / T_b(i)) ^ (-g*M/(R*L_b(i)));
else
    P = P_b(i) * exp(-g*M*(h-h_b(i))/(R*T_b(i)));
end