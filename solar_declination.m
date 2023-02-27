function angle = solar_declination(day)
% Calculate the Solar Declination Angle in degrees on a given date in the
% Julian calendar
angle = 23.45 * sind(360 * (day - 81) / 365);