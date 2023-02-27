function PlotIrradiance(day, lat, alt)
% Plot the DNI, DHI, and GHI over the course of a day, at a given position
t=0:1/60:24;
Id = zeros(size(t));
Idiff = zeros(size(t));
Ig = zeros(size(t));
for i = 1:length(t)
    Id(i) = DNI(t(i), day, lat, alt);
    Idiff(i) = DHI(t(i), day, lat, alt);
    Ig(i) = GHI(t(i), day, lat, alt);
end
hold off
plot(t,Id);
hold on
plot(t,Idiff);
plot(t,Ig);
hold off;
    