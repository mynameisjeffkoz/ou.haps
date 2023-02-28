function t = HAPS_glideTime(hi, hf, m0, S)
% Calculate the glide time beteween two altitudes for the HAPS at a given
% weight
t = 0;
resolution = .1;
for h=hi:-resolution:hf+resolution
    Vv = HAPS_sinkRate(h, m0, S);
    t = t + resolution/Vv;
end