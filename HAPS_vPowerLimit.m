function V = HAPS_vPowerLimit(h, m0, S)
% Calculate the maximum speed of the HAPS aircraft configuration based on
% the power limit of the motors

% Start with some default aircraft parameters
CD0 = 0.02;
e = 0.8;
AR = 30;
k = 1 / (pi * e * AR);

% Set the precision of the calculation
epsilon = 0.0001;

format longg;
% Calculate the available power in W;
PA = 0.02 * m0 * 1000;

V = 11;
dV = 10;

% Find the minimum power state
while (dV >= epsilon)
    pr1 = HAPS_powerRequired(m0,S,V,h);
    pr2 = HAPS_powerRequired(m0,S,V + dV,h);
    if (pr2 > pr1)
        V = V - dV;
        dV = dV / 10;
    else
        V = V + dV;
    end
end

% Reset dV
dV = 10;

% Check if above power limit
PR = HAPS_powerRequired(m0,S,V,h);
if (PR > PA)
    V = 0;
    return;
end

% Find the power limited velocity
while (dV >= epsilon)
    PR = HAPS_powerRequired(m0,S,V,h);
    if (PR > PA)
        V = V - dV;
        dV = dV / 10;
    else
        V = V + dV;
    end
end
if V < HAPS_stallSpeed(h,m0,S)
    V = 0;
end

