function V = HAPS_diveSpeed(cap, S, h)
% Calculates the dive speed of the HAPS aircraft, defined as the speed
% after a descent along a 7.5 degree downward slope, at MCT, for a period
% of 20 seconds
dt = .01;
g = 9.80665;
Cd0 = 0.02;
e = 0.8;
AR = 30;
k = 1/(pi*e*AR);
m0 = HAPS_sizing(cap,S);
W = m0 * g;
P = 0.02 * m0 * 1000;
V0 = HAPS_vPowerLimit(h,m0,S);
V = V0;
thetad = 7.5;
theta = deg2rad(thetad);
for t = 0:dt:20
    rho = atmosDensity(h);
    q = 1/2 * rho * V^2;
    T = P / V;
    CL = W * cos(theta)/(q*S);
    CD = Cd0 + k*CL^2;
    Fx = T + W * sin(theta) - q*S*CD;
    ax = Fx/m0;
    V = V + ax*dt;
    h = h - V * sin(theta) * dt;
end
%% Debugging/Outputs code
 %{
h
rho = atmosDensity(h)
V
q = 1/2 * rho * V^2
CL = W / (q*S)
CD = Cd0 + k*CL^2
D = q*S*CD
%}
