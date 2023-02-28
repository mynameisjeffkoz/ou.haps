function m0 = HAPS_sizing(capacity,S)
% Calculate the MTOW of the HAPS aircraft based on a battery capacity in
% kWh
%% Some conversion factors for calculating an improved EWF
kg2lbs = 2.20462;
m2ft = 1000 / 25.4 / 12;
W2hp = 1/745.7;
%%
epsilon = 1/10^6;
Esb = 340;
Wpl = 50;
% Convert wing area into english units
S = S * m2ft^2;
% Vmax in kts, somewhat arbitrary
Vmax = 150;
% Aspect Ratio = fixed 30
AR = 30;
m0 = 0;
Wbat = capacity * 1000 / Esb;
guess = 1000;
count = 0;
while (count < 1000)
    w = guess * kg2lbs;
    hp = 0.04 * 1000 * guess * W2hp;
    p_w = hp / w;
    w_s = w / S;
    EWF = 0 + 1.21*(w)^-0.04...
        * AR^0.14...
        * (p_w)^0.19...
        * (w_s)^-0.20...
        * Vmax^0.05...
        * 0.85;
    m0 = (Wpl + Wbat) / (1 - EWF);
    if (guess < m0 * (1 + epsilon) & guess > m0 * (1 - epsilon))
        break;
    end
    guess = m0;
    count = count + 1;
end
