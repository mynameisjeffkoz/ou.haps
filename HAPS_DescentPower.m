function E = HAPS_DescentPower(hi, hf, capacity,S)
% Calculate the energy usage of the HAPS aircraft while it is gliding,
% using no motors and receiving no solar power.
m0 = HAPS_sizing(capacity,S);
PR = HAPS_FlightPower("GLIDE", hi, m0,S);
t = HAPS_glideTime(hi,hf,m0,S);
E = PR * t /3600 / 1000;
