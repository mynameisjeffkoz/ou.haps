function Id = DNI(time, day, lat, alt)
% Calculate the Direct Normal Irradiance at a given time and position
if (time >= solar_sunrise(day,lat) & time <= solar_sunset(day,lat))
    tau = exp(-AltitudeAirMass(time, day, lat, alt) * 0.35);
    Id = solar_irradiance(day) * tau;
else
    Id = 0;
end