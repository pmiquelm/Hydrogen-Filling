

slopes = zeros(1,20);
fillTimes = zeros(1,20);
maxTemps = zeros(1,20);
avgHeat = zeros(1,20);



for index = 1:20
    slopes(index) = index / 10;
    [fillTimes(index) maxTemps(index) avgHeat(index)] = MainRoutine(...
        slopes(index), @linearRamp, "../Examples/InputFiles/HydrogenExample.dat",{1},0,0,0,0,'../../Results', 'ProvaLinearRamp');
end

figure(1)
plot(slopes,fillTimes)
figure(2)
plot(slopes,maxTemps)
figure(3)
plot(slopes,avgHeat)
