%Author: Pau Miquel Mir
%Date: 07/11/2017

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
% accept any responsibility for use of or reliance on results produced by 
% this software.

for i = 1:tank_number


massDifference = diff(m_gas(i,1:maxt+1));
uDifference = diff(u_gas(i,1:maxt+1));
pressureDifference = diff(P_gas(i,1:maxt+1));


disp(massDifference(1:1000:end))
disp(uDifference(1:1000:end))
disp(pressureDifference(1:1000:end))

% [maxPressure, index] = max(P_gas(i,1:maxt+1)');
% 
% disp("**********************")
% disp(maxPressure)
% disp(index)
% disp(P_gas(i,10000:10100))
% disp(P_gas(i,maxt-100:maxt+1))
% disp(P_gas(i,maxt+1) - P_gas(i,maxt-10000))
% 
%     figure(6)
%     plot(time(1:101),P_gas(i,maxt-99:maxt+1), plotStyle{i}, 'linewidth', 2)
%     hold on
%     xlabel('Time (s)', 'fontsize', 12)
%     ylabel('Pressure (kPa)', 'fontsize', 12)
%     saveas(gcf, strcat(OutputFolder,'merda.png'))
 
index = find(pressureDifference < 0.001, 1)
disp(P_gas(i,index))
Filltime = time(index)
maxTemp = max(Temp_gas_C(i,1:maxt+1))

end