function P = HAPS_IdleDraw()
% Returns the idle power draw for the HAPS aircraft
P_pl = 750;
P_sys = 500;
P = P_pl + P_sys;