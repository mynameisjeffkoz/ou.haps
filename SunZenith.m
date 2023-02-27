function angle = SunZenith(time, day, lat)
% Calculate the Sun's Zenith at a given time and place
elevation = SunElevation(time, day, lat);
angle = 90 - elevation;