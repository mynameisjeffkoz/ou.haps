function AM = AltitudeAirMass(time, day, lat, alt)
% Calculate the air mass between the sun and panel at any altitude
delta = PressureRatio(alt);
AM_G = GroundAirMass(time, day, lat);
AM = delta * AM_G;