function delta = PressureRatio(alt)
% Calculate the pressure ratio at a given altitude
P_0 = 101325;
delta = AtmosphericPressure(alt) / P_0;