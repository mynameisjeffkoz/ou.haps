function [t,E,dh] = HAPS_sunset(alt, m0, S, t_start)
% Calculate the energy usage and time in cruise for the period in which
% there is no longer enough solar energy to fully power the aircraft
%% Starting Parameters
day = 355;
lat = 20;
t = t_start;
e_area = 1;
e_panel = 0.23;
e_batt = 0.96;
eff_area = S * e_area * e_panel;
% Energy burn and altitude loss starts at 0
E = 0;
dh = 0;
%% Phase 1: Full Power glide
% For as long as the aircraft is fully powered, run the systems entirely
% off of solar
% Calculate power draw
PR = HAPS_FlightPower("GLIDE",alt,m0,S);
% Calculate power target
GHI_tgt = PR / eff_area;
% For as long as GHI is above the target
while (GHI(t+1/60,day,lat, alt-dh) > GHI_tgt)
    % No energy usage
    % Calculate sink rate
    Vv = HAPS_sinkRate(alt-dh,m0,S);
    % Add sink to the altitude change
    dh = dh + Vv * 60;
    % Tick forward
    t = t + 1/60;
end
%% Phase 2: Partial Power glide
% For as long as the aircraft gets some power, keep taking on power
while (GHI(t+1/60,day,lat, alt-dh) > 0)
    % Calculate the net power
    P_net = PR - GHI(t+1/60,day,lat,alt-dh) * eff_area;
    % Calculate the energy used
    E = E + P_net / 1000 / 60 / e_batt;
    % Calculate sink rate
    Vv = HAPS_sinkRate(alt-dh,m0,S);
    % Add sink to the altitude change
    dh = dh + Vv * 60;
    % Tick time forwards
    t = t + 1/60;
end
t = t - t_start;