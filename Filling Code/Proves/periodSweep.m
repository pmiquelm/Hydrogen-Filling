periods = 0.05:0.05:5;

fillTimes = zeros(1,length(periods));
maxTemps = zeros(1,length(periods));
avgHeat = zeros(1,length(periods));

for index=1:length(periods)
    disp(periods(index))
    [fillTimes(index) maxTemps(index) avgHeat(index)] = MainRoutine(...
        [70000, periods(index), 10,0], @squareWave, "../Examples/InputFiles/HydrogenExample.dat",{1},0,0,0,0,'../../Results', 'ProvaLinearRamp');
end

figure(1)
plot(periods,fillTimes)
figure(2)
plot(periods,maxTemps)
figure(3)
plot(periods,avgHeat)