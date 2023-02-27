function RST = RealSolarTime(time, day)
% Convert the local time to real solar time
% Assumes no longitudinal correction is necessary
RST = time + (EquationOfTime(day) / 60);