function P = HAPS_FlightPower(condition, alt, w0)
% Calculate the total power draw at flight conditions, inlcuding system and
% payload power usage.
e_prop = 0.8;
e_motor = 0.95;
e_overall = e_prop * e_motor;
if (condition == "SLUF")
    P = HAPS_SLUFPower(alt,w0) / e_overall + HAPS_IdleDraw();
elseif (condition == "CLIMB")
    P = w0 * .04 * 1000 / e_overall + HAPS_IdleDraw();
elseif (condition == "GLIDE")
    P = HAPS_IdleDraw();
end