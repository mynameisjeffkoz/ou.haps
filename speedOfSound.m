function a = speedOfSound(h)
% Returns the speed of sound under standard atmospheric conditions,
% at a given altitude
gamma = 1.4;
R = 287.05;
T = altitude_temp(h);
a = sqrt(gamma * R * T);