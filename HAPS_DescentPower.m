function E = HAPS_DescentPower(hi, hf, capacity,S)
% Calculate the energy usage of the HAPS aircraft while it is gliding,
% using no motors and receiving no solar power.
w0 = HAPS_sizing(capacity);
PR = HAPS_FlightPower("GLIDE", hi, w0,S);
t = HAPS_glideTime(hi,hf,w0,S);
E = PR * t /3600 / 1000;
