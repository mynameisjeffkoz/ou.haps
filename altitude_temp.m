function T = altitude_temp(h)
% Return the air temperature (in K) at a given altitude
T_b = [288.15 216.65 216.65 228.65 270.65 270.65 214.65];
h_b = [0 11000 20000 32000 47000 51000 71000 100000];
L_b = [-.0065 0 0.001 0.0028 0 -0.0028 -0.002];
for i = 1:(length(h_b) - 1)
    if h >= h_b(i) & h < h_b(i + 1)
        break
    end
end
T = T_b(i) + L_b(i) * (h - h_b(i));