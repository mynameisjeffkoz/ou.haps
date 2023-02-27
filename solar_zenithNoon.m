function angle = solar_zenithNoon(lat, day)
% Calculate the zenith of the sun at noon on a given day and latitude
angle = 90 - solar_altNoon(lat, day);