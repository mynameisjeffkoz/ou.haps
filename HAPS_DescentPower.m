function E = HAPS_DescentPower(hi, hf, capacity)
% Calculate the energy usage of the HAPS aircraft while it is gliding,
% using no motors and receiving no solar power.
w0 = HAPS_sizing(capacity);
PR = HAPS_FlightPower("GLIDE", hi, w0);
t = HAPS_glideTime(hi,hf,w0);
E = PR * t /3600 / 1000;
