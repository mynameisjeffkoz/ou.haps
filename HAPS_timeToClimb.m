function t = HAPS_timeToClimb(hi, hf, m0)
% Calculate the time needed to climb between two altitudes at a given
% weight
t = 0;
Vv = 0;
resolution = .1;
for h = (hi+resolution):resolution:hf
    Vv = HAPS_rateOfClimb(h, m0);
    t = t + resolution / Vv;
end