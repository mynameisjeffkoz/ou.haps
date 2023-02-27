function angle = solar_altNoon(lat, day)
% Calculate the altitude of the sun at noon given a day and latitude
angle = 90 - lat + solar_declination(day);