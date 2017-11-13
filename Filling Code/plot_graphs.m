%Author: Vishagen Ramasamy, Jannic Holzer
%Date: 20/09/2017

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
%accept any responsibility for use of or reliance on results produced by 
%this software.

Temp_gas_C = Temp_gas - 273.15;

% PassStruct = {tank_number, time, Temp_gas_C, plotStyle, inputFileNames, ...
%                 maxt, mfr, blnOneZone, Temp_wall, int_pt_liner_laminate}
% set(0, 'userdata', PassStruct)
% OutputUI

for i = 1:tank_number
    if l_d(i) <= 3 | blnOneZone{i} == 1
        
        if blnOneZone{i} == 1
            FileRoot = strcat('_', inputFileNames{i}(1:end-4),'_(One Zone)', '.csv');
        else
            FileRoot = strcat('_', inputFileNames{i}(1:end-4), '.csv');
        end
        
       OutName = strcat(OutputFolder, OutputPrefix, FileRoot)
        % Write 1 Zone model output
 
        csvwrite(OutName,[time',Temp_gas_C(i,1:maxt+1)',P_gas(i,1:maxt+1)']);
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Time (s)'}, 'Results', 'A1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Mass (kg)'}, 'Results', 'B1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [time', m_gas(i,1:maxt+1)'], 'Results', 'A2');
%         
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Internal Energy (J)'}, 'Results', 'C1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [Ugas(i,1:maxt+1)'], 'Results', 'C2');
        
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Specific Internal Energy (J/kg)'}, 'Results', 'D1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [u_gas(i,1:maxt+1)'], 'Results', 'D2');
%         
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Density (kg/m^3)'}, 'Results', 'E1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [rho_gas(i,1:maxt+1)'], 'Results', 'E2');
%         
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Pressure (kPa)'}, 'Results', 'F1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [P_gas(i,1:maxt+1)'], 'Results', 'F2');
%         
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Temperature (°C)'}, 'Results', 'G1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [Temp_gas_C(i,1:maxt+1)'], 'Results', 'G2');
%         
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Liner Heat Transfer (W)'}, 'Results', 'H1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [Qsurf(i,1:maxt+1)'], 'Results', 'H2');
%         
        if Inner_wall_boundary(i) == 2
            
%             xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Max. Liner Temp. (°C)'}, 'Results', 'I1');
%             xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [(Temp_wall{i}(1,1:maxt+1) - 273)'], 'Results', 'I2');
%             
%             xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Max. Laminate Temp. (°C)'}, 'Results', 'J1');
%             xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [(Temp_wall{i}(int_pt_liner_laminate(1) + 1,1:maxt+1) - 273)'], 'Results', 'J2');
            
        end
        
    else
        FileRoot = strcat('_', inputFileNames{i}(1:end-4), '.csv');
        OutName = strcat(OutputFolder, OutputPrefix, FileRoot);
        csvwrite(OutName,[time',Temp_gas_C(i,1:maxt+1)',P_gas(i,1:maxt+1)']);

%         % Write 2 Zone model output
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Time (s)'}, 'Results', 'A1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Mass (kg)'}, 'Results', 'B1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [time', m_gas(i,1:maxt+1)'], 'Results', 'A2');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Mass - Zone 1 (kg)'}, 'Results', 'C1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [m_gas_zone1{i}(1:maxt+1)'], 'Results', 'C2');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Mass - Zone 2 (kg)'}, 'Results', 'D1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [m_gas_zone2{i}(1:maxt+1)'], 'Results', 'D2');
% 
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Internal Energy (J)'}, 'Results', 'E1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [Ugas(i,1:maxt+1)'], 'Results', 'E2');
% 
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Specific Internal Energy (J/kg)'}, 'Results', 'F1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [u_gas(i,1:maxt+1)'], 'Results', 'F2');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Specific Internal Energy - Zone 1 (J/kg)'}, 'Results', 'G1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [u_gas_zone1{i}(1:maxt+1)'], 'Results', 'G2');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Specific Internal Energy - Zone 2 (J/kg)'}, 'Results', 'H1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [u_gas_zone2{i}(1:maxt+1)'], 'Results', 'H2');
% 
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Density (kg/m^3)'}, 'Results', 'I1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [rho_gas(i,1:maxt+1)'], 'Results', 'I2');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Density - Zone 1(kg/m^3)'}, 'Results', 'J1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [rho_gas_zone1{i}(1:maxt+1)'], 'Results', 'J2');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Density - Zone 2(kg/m^3)'}, 'Results', 'K1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [rho_gas_zone2{i}(1:maxt+1)'], 'Results', 'K2');
% 
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Pressure (kPa)'}, 'Results', 'L1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [P_gas(i,1:maxt+1)'], 'Results', 'L2');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Pressure - Zone 1 (kPa)'}, 'Results', 'M1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [P_gas_zone1{i}(1:maxt+1)'], 'Results', 'M2');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Pressure - Zone 2 (kPa)'}, 'Results', 'N1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [P_gas_zone2{i}(1:maxt+1)'], 'Results', 'N2');
% 
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Temperature (°C)'}, 'Results', 'O1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [Temp_gas_C(i,1:maxt+1)'], 'Results', 'O2');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Temperature - Zone 1 (°C)'}, 'Results', 'P1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [(Temp_gas_zone1{i}(1:maxt+1) - 273)'], 'Results', 'P2');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Gas Temperature - Zone 2 (°C)'}, 'Results', 'Q1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [(Temp_gas_zone2{i}(1:maxt+1) - 273)'], 'Results', 'Q2');
% 
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Liner Heat Transfer (W)'}, 'Results', 'R1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [(Qsurf_zone1{i}(1:maxt+1)+Qsurf_zone2{i}(1:maxt+1))'], 'Results', 'R2');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Liner Heat Transfer - Zone 1 (W)'}, 'Results', 'S1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [Qsurf_zone1{i}(1:maxt+1)'], 'Results', 'S2');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Liner Heat Transfer - Zone 2 (W)'}, 'Results', 'T1');
%         xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [Qsurf_zone2{i}(1:maxt+1)'], 'Results', 'T2');
        
        if Inner_wall_boundary(i) == 2
            
%             xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Max. Liner Temp. Zone 1 (°C)'}, 'Results', 'U1');
%             xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [(Temp_wall_zone1{i}(1,1:maxt+1) - 273)'], 'Results', 'U2');
% 
%             xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Max. Laminate Temp. Zone 1 (°C)'}, 'Results', 'V1');
%             xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [(Temp_wall_zone1{i}(int_pt_liner_laminate(1) + 1,1:maxt+1) - 273)'], 'Results', 'V2');
%             
%             xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Max. Liner Temp. Zone 2 (°C)'}, 'Results', 'W1');
%             xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [(Temp_wall_zone2{i}(1,1:maxt+1) - 273)'], 'Results', 'W2');
%             
%             xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), {'Max. Laminate Temp. Zone 2 (°C)'}, 'Results', 'X1');
%             xlswrite(strcat(OutputFolder, OutputPrefix, FileRoot), [(Temp_wall_zone2{i}(int_pt_liner_laminate(1) + 1,1:maxt+1) - 273)'], 'Results', 'X2');
        
        end
        
    end
end

% Define a cell array containing colours and line styles for 6 individual
% plots
plotStyle = {'b-', 'r-', 'g-', 'y-', 'm-', 'c-'};
wall_temp_count = 1;
blnShowFigures_3_4 = 0;

% Add plots of quantity to each plot, one calculated tank at a time.

for i=1:tank_number
    
    figure(1)
    plot(time,Temp_gas_C(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Cylinder gas temperature (°C)', 'fontsize', 12)
    
    disp(strcat(OutputFolder,'GasTemperature_vs_time.png'))
    saveas(gcf, strcat(OutputFolder,'GasTemperature_vs_time.png'))
    
    figure(2)
    plot(time,mfr(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Mass flow rate (kg/s)', 'fontsize', 12)
    saveas(gcf, strcat(OutputFolder,'mfr_vs_time.png'))
    
    figure(3)
    plot(time,P_gas(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Pressure (kPa)', 'fontsize', 12)
    saveas(gcf, strcat(OutputFolder,'pres_vs_time.png'))
    
    
    if Inner_wall_boundary(i) == 2 & (l_d(i) <= 3 | blnOneZone{i} == 1)
        figure(4)
        Temp_wall_C = Temp_wall{i}(1,1:maxt+1) - 273;
        plot(time,Temp_wall_C, plotStyle{i}, 'linewidth', 2)
        hold on
        xlabel('Time (s)', 'fontsize', 12)
        ylabel('Max. Liner Temp. (°C)', 'fontsize', 12)
        saveas(gcf, strcat(OutputFolder,'MaxLinerTemp_vs_time.png'))
        blnShowFigures_3_4 = 1;
    elseif Inner_wall_boundary(i) == 2 & l_d(i) > 3 & blnOneZone{i} == 0
        figure(4)
        Temp_wall_C = Temp_wall_zone1{i}(1,1:maxt+1) - 273;
        plot(time,Temp_wall_C, plotStyle{i}, 'linewidth', 2)
        hold on
        xlabel('Time (s)', 'fontsize', 12)
        ylabel('Max. Liner Temp. (°C)', 'fontsize', 12)
        saveas(gcf, strcat(OutputFolder,'MaxLinerTemp_vs_time.png'))
        blnShowFigures_3_4 = 1;
    end
    
    if Inner_wall_boundary(i) == 2 & (l_d(i) <= 3 | blnOneZone{i} == 1)
        figure(5)
        Temp_wall_C = Temp_wall{i}(int_pt_liner_laminate(1) + 1,1:maxt+1) - 273;
        plot(time,Temp_wall_C, plotStyle{i}, 'linewidth', 2)
        hold on
        xlabel('Time (s)', 'fontsize', 12)
        ylabel('Max. Laminate Temp. (°C)', 'fontsize', 12)
        saveas(gcf, strcat(OutputFolder,'MaxLaminateTemp_vs_time.png'))
    elseif Inner_wall_boundary(i) == 2 & l_d(i) > 3 & blnOneZone{i} == 0
        figure(5)
        Temp_wall_C = Temp_wall_zone1{i}(int_pt_liner_laminate(1) + 1,1:maxt+1) - 273;
        plot(time,Temp_wall_C, plotStyle{i}, 'linewidth', 2)
        hold on
        xlabel('Time (s)', 'fontsize', 12)
        ylabel('Max. Laminate Temp. (°C)', 'fontsize', 12)
        saveas(gcf, strcat(OutputFolder,'MaxLaminateTemp_vs_time.png'))
    end
    
    legendInfo{i} = [inputFileNames{i}(1:end-4)]
    
    if Inner_wall_boundary(i) == 2
        wall_temp_legendInfo{wall_temp_count} = [inputFileNames{i}(1:end-4)];
        wall_temp_count = wall_temp_count + 1;
    end
end

% Add legends to completed figures

figure(1)
legend(legendInfo, 'Location', 'southeast')

figure(2)
legend(legendInfo, 'Location', 'northeast')

figure(3)
legend(legendInfo, 'Location', 'northeast')

if blnShowFigures_3_4 == 1
    figure(4)
    legend(wall_temp_legendInfo, 'Location', 'southeast')
    
    figure(5)
    legend(wall_temp_legendInfo, 'Location', 'southeast')
end