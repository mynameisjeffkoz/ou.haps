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
clf
hold on
plot(t,Id);
plot(t,Idiff);
plot(t,Ig);
title("Solar Irradiance For J355 at Latitude 20", 'FontSize', 14)
xlabel("Time (h)")
xlim([0 24]);
xticks(0:4:24);
ylabel ("Solar Irradiance (W/m^2)");
legend({"Direct Normal", "Diffuse Horizontal",...
    "Global Horizontal"}, 'FontSize', 8);
hold off;
    