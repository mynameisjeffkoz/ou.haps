function Vv = HAPS_rateOfClimb(altitude, m0,S)
% Calculate the rate of climb of the HAPS aircraft, based on its current
% altitude and weight
g = 9.80665;
AR = 30;
CD0 = 0.02;
e = 0.8;
k = 1 / (pi*e*AR);
Cl_max = 1.7;
V = 1.2 * HAPS_stallSpeed(altitude, m0,S);
PR = HAPS_SLUFPower(altitude, m0,S);
PA = m0 * .04 * 1000;
PE = PA - PR;
Vv = PE /(g * m0);