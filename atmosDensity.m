function rho = atmosDensity(h) 
%atmosDensity Output the atmospheric density in kg/m^3 at a given height
g = 9.80665;
M_air = 0.0289644;
R_ugc = 8.3144598;
rho_b = [1.2250 0.36391 0.08803 .01322 .00143 .00086 .000064];
T_b = [288.15 216.65 216.65 228.65 270.65 270.65 214.65];
h_b = [0 11000 20000 32000 47000 51000 71000 100000];
L_b = [-.0065 0 0.001 0.0028 0 -0.0028 -0.002];
% Assume minimum density altitude of 0
%{
if h < 0
    h = 0;
end
%}
for i = 1:(length(h_b) - 1)
    if h < 0
        break
    elseif h >= h_b(i) & h < h_b(i + 1)
        break
    end
end
if L_b(i) ~= 0
    rho = rho_b(i) * (T_b(i) / (T_b(i) + (h - h_b(i)) * L_b(i))) ^ (1 + g * M_air / (R_ugc * L_b(i)));
else
    rho = rho_b(i) * exp(-g * M_air * (h - h_b(i)) / (R_ugc * T_b(i)));
end

    

    
        

