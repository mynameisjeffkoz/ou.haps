function h = HAPS_TimedClimb(alt, m0, time)
% Calculate the altitude gained by the HAPS aircraft climbing at full power
% for a specific time period
resolution = 1;
h = alt;
for t =0:resolution:time-resolution
    Vv = HAPS_rateOfClimb(h,m0);
    dh = Vv * resolution;
    h = h + dh;
end
h = h - alt;
