function h = HAPS_serviceCeiling(m0)
% Calculate the service ceiling of the HAPS aircraft, based on a minimum
% rate of climb of 100 ft/min
Vv_min = 100 * .3048 / 60;
dh = 1000;
h0 = 0;
h = h0;
while (dh > 1)
    h
    Vv = HAPS_rateOfClimb(h,m0)
    if (Vv > Vv_min)
        h = h + dh;
    else
        h = h - dh;
        dh = dh / 10;
    end
end
