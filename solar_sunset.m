function time = solar_sunset(day, lat)
% Calculate the time of sunset on a given day, at a given latitude
time = 12 + acos(-tand(lat) * tand(solar_declination(day))) * 12 / pi;