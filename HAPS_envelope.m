function HAPS_envelope(cap, S)
% Plot the flight envelope of the HAPS aircraft with a given battery
% capacity and wing area
% Calculate the mass of the aircraft
m0 = HAPS_sizing(cap, S);
% Calculate the service ceiling of the aircraft
h_max = HAPS_serviceCeiling(m0, S);
% Do some math to round up to a multiple of 10 km
h_max = ceil(h_max / 10000) * 10000;
h = 0:1:h_max;
V_s = zeros(size(h));
for i=1:length(h)
    % Calculate the stall speed
    V_s(i) = HAPS_stallSpeed(h(i),m0,S);
    % Calculate the power limited speed
    v_pl = HAPS_vPowerLimit(h(i),m0,S);
    % Calculate the mach limited speed
    v_ml = 0.3 * speedOfSound(h);
    % Pick the lower of the two
    if (v_pl < v_ml)
        if (v_pl > 0)
            V_max(i) = v_pl;
        end
    else
        V_max(i) = v_ml;
    end
end
h_max = zeros(size(V_max));
V_D = zeros(size(h_max));
for i=1:(length(h_max))
    h_max(i) = i - 1;
    V_D(i) = HAPS_diveSpeed(cap,S,h_max(i));
end
clf
h = h / 1000;
h_max = h_max / 1000;
hold on
plot(V_s, h)
plot (V_max, h_max);
plot (V_D, h_max);
plot([0 90], [HAPS_serviceCeiling(m0, S)/1000,...
    HAPS_serviceCeiling(m0, S)/1000])
plot([0 90], [h_max(length(h_max)), h_max(length(h_max))])
legend('Stall Speed', 'Power Limited Speed', 'Dive Speed',...
    'Service Ceiling', 'Maximum Altitude');
xlabel('Velocity (m/s)');
ylabel('Altitude (km)');
hold off;