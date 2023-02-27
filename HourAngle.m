function HA = HourAngle(time, day)
% Calculate the Hour Angle for a given local time and day
HA = 15 * (RealSolarTime(time, day) - 12);