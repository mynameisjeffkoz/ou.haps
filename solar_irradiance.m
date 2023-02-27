function irradiance = solar_irradiance(day)
% Calculate the solar irradiance experienced by the Earth, without
% atmospheric effects
%TODO: lower this value slightly
G = 1367;
angle = day_angle(day);
corr = 1.00011 + 0.034221 * cosd(angle) + 0.00128 * sind(angle);
corr = corr + 0.000719 * cosd(2 * angle) + 0.000077 * sind(2 * angle);
irradiance = G * corr;