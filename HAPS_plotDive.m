function HAPS_plotDive(cap,S)
% Plots the dive speed from ground level to the aircraft's service ceiling
m0 = HAPS_sizing(cap,S);
h_max = HAPS_serviceCeiling(m0,S);
h = 0:10:h_max;
VD = zeros(size(h));
q = zeros(size(h));
for i=1:length(h)
    rho = atmosDensity(h(i));
    VD(i) = HAPS_diveSpeed(cap,S,h(i));
    q(i) = 1/2 * rho * VD(i)^2;
end
[maxQ,idx] = max(q);
maxQ
h_maxQ = h(idx)
V_maxQ = VD(idx) 
clf
hold on;
h = h / 1000;
plot(VD, h);
plot(q,h);
legend('Dive Velocity', 'Dynamic Pressure')