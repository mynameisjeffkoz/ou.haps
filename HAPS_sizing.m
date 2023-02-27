function w0 = HAPS_sizing(capacity)
% Calculate the MTOW of the HAPS aircraft based on a battery capacity in
% kWh
epsilon = 1/10^6;
Esb = 340;
Wpl = 50;
w0 = 0;
Wbat = capacity * 1000 / Esb;
guess = 1000;
count = 0;
while (count < 100)
    EWF = 0.88 * guess ^(-0.05);
    w0 = (Wpl + Wbat) / (1 - EWF);
    if (guess < w0 * (1 + epsilon) & guess > w0 * (1 - epsilon))
        break;
    end
    guess = w0;
    count = count + 1;
end

