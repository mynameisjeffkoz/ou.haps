function EOT = EquationOfTime(day)
% Approximate the Equation of Time, in minutes, on a given Julian date
% Produces an RMS error of 3.7s, with max error 6.0s 
n = 360 / 365.24;
A = (day + 9) * n;
B = A + 1.914 * sind((day - 3) * n);
C = (A - atand(tand(B)/cosd(23.44))) / 180;
EOT = 720 * (C - round(C));
