function t = LastGHI(value, day, lat, alt)
% Calculate the last minute at which the given GHI is available

% Start the time counter at 0
t = 0;

% While GHI is level or increasing
while GHI(t,day,lat,alt) < value
    % Keep time rolling forward
    t = t + 1/60;
    if t >= 24
        break
    end
end

for t=t:1/60:24
    if GHI(t+1/60,day,lat,alt) <= value
        break
    end
end
