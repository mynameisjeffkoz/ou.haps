function S = HAPS_MinimumWing(hi,hf,capacity,state,DOD)
% Determine the minimum size of the wing to successfully complete a
% climb/recharge phase of flight with full battery
S = 1000;
dS = 100;
while (dS >= 1)
    t = HAPS_ClimbRecharge(hi, hf, capacity, state, DOD, S);
    if (t > 0)
       S = S - dS;
    else
       S = S + dS;
       dS = dS / 10;
    end
end

