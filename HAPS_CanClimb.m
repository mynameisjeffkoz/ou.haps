function t_end = HAPS_CanClimb(hi,hf,w0,t_start)
% Find if the HAPS aircraft can complete a full power climb on full solar
% power
day = 355;
lat = 20;
S = 58.8;
e_area = 0.9;
e_panel = 0.23;
eff_area = S * e_area * e_panel;
PR = HAPS_FlightPower("CLIMB", hi, w0);
t = HAPS_timeToClimb(hi, hf, w0) / 3600;
t_end = t_start + t;
if (GHI(t_end, day, lat, hi) >= PR/eff_area)
    fprintf("Climb successful");
else
    fprintf("Climb failed");
    GHI(t_end, day, lat, hi) * eff_area
end
