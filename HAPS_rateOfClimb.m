function Vv = HAPS_rateOfClimb(altitude, w0)
% Calculate the rate of climb of the HAPS aircraft, based on its current
% altitude and weight
g = 9.80665;
AR = 30;
CD0 = 0.02;
e = 0.8;
k = 1 / (pi*e*AR);
Cl_max = 1.7;
S = 58.8;
V = 1.2 * HAPS_stallSpeed(altitude, w0);
PR = HAPS_SLUFPower(altitude, w0);
PA = w0 * .02 * 1000;
PE = PA - PR;
Vv = PE /(g * w0);