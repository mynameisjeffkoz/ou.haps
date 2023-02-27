function output = HAPS_SizingTable(c_max, c_int, c_min, DOD_min, DOD_interval, DOD_max, h_min, h_max)
% Generate a table of possible HAPS sizing configurations based on battery
% capacity and depth of discharge
 index = 1;
 
if (c_min <= 20)
    c_min = 20;
end

if (DOD_max > 100)
    DOD_max = 100;
end

if DOD_min < 1
    DOD_min = 1;
end

 
 for c = c_max:-c_int:c_min
     for d=DOD_min:DOD_interval:DOD_max
         cap(index) = c;
         DOD(index) = d;
         cycle(index) = HAPS_FlightCycle(h_min,h_max,c,d);
         w0(index) = HAPS_sizing(c);
         index = index + 1;
     end
 end
 


output = table;
output.Capacity = cap';
output.DOD = DOD';
output.Cycle = cycle';
output.FS = cycle'./24;
output.Weight = w0';