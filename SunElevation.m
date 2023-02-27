function angle = SunElevation(time, day, lat)
% Calculate the elevation angle of the sun at a specific time and place
% Find the declination angle
dec = solar_declination(day);
HRA = HourAngle(time,day);
angle = asind(sind(dec) * sind(lat) + cosd(dec) * cosd(lat) * cosd(HRA));