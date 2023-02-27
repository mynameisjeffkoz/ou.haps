function AM = GroundAirMass(time, day, lat)
% Calculate the air mass between the ground and the sun
angle = SunZenith(time, day, lat);
AM = 1 / (cosd(angle) + 0.50572 * (96.07995 - angle) ^ -1.6364);