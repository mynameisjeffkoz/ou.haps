function t = HAPS_glideTime(hi, hf, w0)
% Calculate the glide time beteween two altitudes for the HAPS at a given
% weight
t = 0;
resolution = .1;
for h=hi:-resolution:hf+resolution
    Vv = HAPS_sinkRate(h, w0);
    t = t + resolution/Vv;
end