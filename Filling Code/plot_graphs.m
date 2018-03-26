%Author: Vishagen Ramasamy, Jannic Holzer
%Date: 20/09/2017

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
%accept any responsibility for use of or reliance on results produced by 
%this software.

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

       OutName = fullfile(OutputFolder, strcat(OutputPrefix, FileRoot))
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
        OutName = fullfile(OutputFolder, strcat(OutputPrefix, FileRoot));
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
    saveas(gcf, fullfile(OutputFolder,'GasTemperature_vs_time.png'))
    
    figure(2)
    plot(time,mfr(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Mass flow rate (kg/s)', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'mfr_vs_time.png'))
    
    figure(3)
    plot(time,P_gas(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Pressure (kPa)', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'pres_vs_time.png'))
    
    
    if Inner_wall_boundary(i) == 2 && (l_d(i) <= 3 || blnOneZone{i} == 1)
        figure(4)
        Temp_wall_C = Temp_wall{i}(1,1:maxt+1) - 273;
        plot(time,Temp_wall_C, plotStyle{i}, 'linewidth', 2)
        hold on
        xlabel('Time (s)', 'fontsize', 12)
        ylabel('Max. Liner Temp. (°C)', 'fontsize', 12)
        saveas(gcf, fullfile(OutputFolder,'MaxLinerTemp_vs_time.png'))
        blnShowFigures_3_4 = 1;
    elseif Inner_wall_boundary(i) == 2 && l_d(i) > 3 && blnOneZone{i} == 0
        figure(4)
        Temp_wall_C = Temp_wall_zone1{i}(1,1:maxt+1) - 273;
        plot(time,Temp_wall_C, plotStyle{i}, 'linewidth', 2)
        hold on
        xlabel('Time (s)', 'fontsize', 12)
        ylabel('Max. Liner Temp. (°C)', 'fontsize', 12)
        saveas(gcf, fullfile(OutputFolder,'MaxLinerTemp_vs_time.png'))
        blnShowFigures_3_4 = 1;
    end
    
    if Inner_wall_boundary(i) == 2 && (l_d(i) <= 3 | blnOneZone{i} == 1)
        figure(5)
        Temp_wall_C = Temp_wall{i}(int_pt_liner_laminate(1) + 1,1:maxt+1) - 273;
        plot(time,Temp_wall_C, plotStyle{i}, 'linewidth', 2)
        hold on
        xlabel('Time (s)', 'fontsize', 12)
        ylabel('Max. Laminate Temp. (°C)', 'fontsize', 12)
        saveas(gcf, fullfile(OutputFolder,'MaxLaminateTemp_vs_time.png'))
    elseif Inner_wall_boundary(i) == 2 & l_d(i) > 3 & blnOneZone{i} == 0
        figure(5)
        Temp_wall_C = Temp_wall_zone1{i}(int_pt_liner_laminate(1) + 1,1:maxt+1) - 273;
        plot(time,Temp_wall_C, plotStyle{i}, 'linewidth', 2)
        hold on
        xlabel('Time (s)', 'fontsize', 12)
        ylabel('Max. Laminate Temp. (°C)', 'fontsize', 12)
        saveas(gcf, fullfile(OutputFolder,'MaxLaminateTemp_vs_time.png'))
    end
    
    legendInfo{i} = [inputFileNames{i}(1:end-4)];
    
    if Inner_wall_boundary(i) == 2
        wall_temp_legendInfo{wall_temp_count} = [inputFileNames{i}(1:end-4)];
        wall_temp_count = wall_temp_count + 1;
    end
    
    figure(6)
    plot(time,Nu_ss(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Nusselt Number steady', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'nuss_vs_time.png'))
    
    figure(7)
    plot(time,Nu_hys(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Nusselt Number hysteresis', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'nuhys_vs_time.png'))

    figure(8)
    plot(time,heat_coef_forced(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    plot(time,heat_coef_natural(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    plot(time,heat_coef_total(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Heat Transfer Coefficient', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'h_vs_time.png'))
    
    figure(9)
    plot(time,k_gas(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Thermal Conductivity', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'k_vs_time.png'))
    
    figure(10)
    plot(time,Re_entrance_actual(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Reynolds number', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'Re_vs_time.png'))
    
    figure(11)
    plot(time,beta_gas(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Beta', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'Beta_vs_time.png'))
    
    figure(12)
    plot(time,cp_gas(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('cp', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'cp_vs_time.png'))
    
    figure(13)
    plot(time,visc_gas(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    plot(time,visc_exit(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Viscosity', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'mu_vs_time.png'))
    
    figure(14)
    plot(time,Ra(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Ra', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'Ra_vs_time.png'))
    
    figure(15)
    plot(time,Nu_n(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Nusselt natural', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'Nu_n_vs_time.png'))
    
    figure(16)
    surf(Temp_wall{i}(:,1:1000:end))
    hold on
    saveas(gcf, fullfile(OutputFolder,'Temp_vs_time_vs_distance.png'))
    
    figure(17)
    plot(m_gas(i,1:maxt+1), Temp_gas_C(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Mass (kg)', 'fontsize', 12)
    ylabel('Temperature', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'Temp_vs_mass.png'))

    figure(18)
    plot(time, Temp_gas_C(i,1:maxt+1)-(Temp_wall{i}(1,1:maxt+1) - 273), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Temperature Difference (Gas - Wall)', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'Delta_Temp_vs_time.png'))
    
    figure(19)
    plot(time, tau(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Tau', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'Tau_vs_time.png'))
    
    figure(20)
    plot(time, vel_exit(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Velocity (ms-1)', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'Vel_vs_time.png'))
    
    figure(21)
    plot(InletPressureData, plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 12)
    ylabel('Pressure (kPa)', 'fontsize', 12)
    saveas(gcf, fullfile(OutputFolder,'InletPressure_vs_time.png'))
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

figure(6)
legend(legendInfo, 'Location', 'northeast')

figure(7)
legend(legendInfo, 'Location', 'northeast')

figure(8)
legend(legendInfo, 'Location', 'northeast')

figure(9)
legend(legendInfo, 'Location', 'northeast')

figure(10)
legend(legendInfo, 'Location', 'northeast')

figure(11)
legend(legendInfo, 'Location', 'northeast')

figure(12)
legend(legendInfo, 'Location', 'northeast')

figure(13)
legend(legendInfo, 'Location', 'northeast')

figure(14)
legend(legendInfo, 'Location', 'northeast')

figure(15)

figure(16)
legend(legendInfo, 'Location', 'northeast')

figure(17)
legend(legendInfo, 'Location', 'northeast')

figure(18)
legend(legendInfo, 'Location', 'northeast')

figure(19)
legend(legendInfo, 'Location', 'northeast')

figure(20)
legend(legendInfo, 'Location', 'northeast')

figure(21)
legend(legendInfo, 'Location', 'northeast')