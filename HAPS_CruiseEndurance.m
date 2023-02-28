function t = HAPS_CruiseEndurance(alt, capacity, state, DOD,S)
% Calculate the cruise endurance of the HAPS aircraft at a specified
% altitude, and with a certain battery size
w0 = HAPS_sizing(capacity);
e_batt = 0.96;
PR = HAPS_FlightPower("SLUF", alt, w0,S);
% Correct depth of discharge if entered as whole number percentage
if DOD > 1
    DOD = DOD / 100;
end

% Calculate battery capacity limits as needed
min_charge = (1-DOD)/2 * capacity;
t = (state - min_charge) * 1000 / PR * e_batt;