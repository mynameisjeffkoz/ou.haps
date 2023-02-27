function IG = GHI(time, day, lat, alt)
% Calculate the Global Horizontal Irradiance at a given time and place
Id = DNI(time, day, lat, alt);
angle = SunZenith(time, day, lat);
Idiff = DHI(time, day, lat, alt);
IG = Id * cosd(angle) + Idiff;