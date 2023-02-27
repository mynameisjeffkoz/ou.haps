function Idif = DHI(time, day, lat, alt)
% Calculate the Diffuse Horizontal Intensity at a given time position
Id = DNI(time, day, lat, alt);
Idif = 0.08 * Id * exp(-alt / 7000);