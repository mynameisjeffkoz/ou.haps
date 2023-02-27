function time = FindGHI(value, day, lat, alt)
% Find the time (to the nearest minute) when a given power target is
% available
for time = 0:1/60:24
    if GHI(time, day, lat, alt) >= value
        break
    end
end