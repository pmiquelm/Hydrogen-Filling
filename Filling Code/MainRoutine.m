%Author: Vishagen Ramasamy, Jannic Holzer, Pau Miquel
%Date: 20/09/2017

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
%accept any responsibility for use of or reliance on results produced by 
%this software.

% clear;  % Removes variables from workspace memory
% close;  % Closes any figures that are still open

%%

function caca = MainRoutine(inputFiles, blnUseStandardData, ... 
    PressureDataFile,TempDataFile, blnOneZone, OutputFileName, ...
    OutputFolder, refpropdir, ConstTempK, ConstPressKPa)

% % All data gathered from FrontEndUI is stored in a struct inside 'userdata'
% PassedData = get(0, 'userdata')
% 
% % Get names for configuration files
% inputFileNames = PassedData(1)
% inputFileNames = inputFileNames{1}
% 
% % Get paths for configuration files
% inputPathNames = PassedData(2)
% inputPathNames = inputPathNames{1}
% 
% % Concatenate input file paths with input file names
% inputFiles = []
% for i = 1:numel(inputFileNames)
%     inputFiles = [inputFiles; strcat(inputPathNames(i), inputFileNames(i))]
% end

% % Get boolean for use of constant inlet profile, 0 = input .xlsx, 1 = use constant
% blnUseStandardDataPass = PassedData(3)
% blnUseStandardData = blnUseStandardDataPass{1}

% % Get location of .xlsx file specifying inlet pressure profile 
% PressureDataFile = PassedData(4)
% PressureDataFile = PressureDataFile{1}

% % Get location of .xlsx file specifying inlet temperature profile 
% TempDataFile = PassedData(5)
% TempDataFile = TempDataFile{1}

% Get number of tanks to run simulation for
tank_number = size(inputFiles, 1)

% Read inlet profile for pressure and temperature from .xlsx files
if blnUseStandardData == 0
    InletPressureData = xlsread(PressureDataFile)
    InletTempData = xlsread(TempDataFile)
end

% % Get boolean array for whether to force one zone model for tanks
% blnOneZone = PassedData(6)
% blnOneZone = blnOneZone{1}
% 
% % Get root name for output .xlsx and .png files
% OutputFileName = PassedData(7)
% OutputFileName = OutputFileName{1}
% 
% % Get folder to save resulting .xlsx and .png files into
% OutputFolder = PassedData(8)
% OutputFolder = OutputFolder{1}
% 
% % Get refprop directory
% refpropdir = PassedData(9)
% refpropdir = refpropdir{1}
% 
% % Get constant input profile values
% ConstTempK = PassedData(10)
% ConstTempK = ConstTempK{1}
% 
% ConstPressKPa = PassedData(11)
% ConstPressKPa = ConstPressKPa{1}

%% Select whether conjuagte heat transfer or isothermal inner boundary conditions of the tank(s)
% If conjugate heat transfer is selected, the outer wall boundary
% conditions must be selected as either isothermal or adiabatic
for i=1:tank_number
    inputvalues = importdata(inputFiles{i}, '\t')
    inputdata = inputvalues.data
    Inner_wall_boundary(i) = inputdata(1); % 1 => isothermal, 2 => conjugate
    if Inner_wall_boundary(i)== 2
        PCM_inclusion(i) =  inputdata(2); %1 => no PCM inclusion, 2 => PCM inclusion
        Outer_wall_boundary(i) = inputdata(3); %1 => isothermal, 2 => adiabatic
    end
end

%% Material properties of liner and laminate
Tank_material_properties   % Call script that has the tank(s) material properties

%% Tank(s) dimensions
Tank_dimension             % Call script that has the tank(s) dimension

%% Discretization of the tank walls
Discretisation_of_tank_structure

%% Calculate structural mass of tank(s)
for i=1:tank_number
    if (Inner_wall_boundary(i) == 2 && PCM_inclusion(i) == 2)
    Structural_mass_tank(i) = calculate_mass_tank_PCM(i,r_tank,rho_liner,rho_laminate,rho_PCM_solid,PCM_thickness,liner_thickness,Wall_thickness_total,l_tank_straight);   % Call function that calculates the structural mass of the tank(s)
    else
    Structural_mass_tank(i) = calculate_mass_tank(i,r_tank,rho_liner,rho_laminate,liner_thickness,Wall_thickness_total,l_tank_straight);                                                                     % Call function that calculates the structural mass of the tank(s)
    end
end
%% Fill time
if blnUseStandardData == 0
    Time_fill = InletPressureData(end,1)          % Fill time in seconds
else
    Time_fill = 37
end

%% Determining the miniumum number of time steps (maxt) required for the compuation of heat transfer across the structure
% The explicit method is used to compute the heat transfer across the
% structure of the cylinder and for stability, the CFL must be less than 0.5

CFL =0.5;
for i=1:tank_number
 if (Inner_wall_boundary(i)== 2 && (PCM_inclusion(i)== 2))   
 maxt_initial(i) = calculate_maxtpcm(i,CFL,alpha_liner, alpha_laminate, dr,Time_fill,rho_PCM_solid,rho_PCM_liquid,cond_PCM,c_PCM_liquid, c_PCM_solid); 
 else
 maxt_initial(i) = calculate_maxtnopcm(i,CFL, alpha_liner, alpha_laminate, Inner_wall_boundary,dr, Time_fill);  % call function that determines the value of maxt    
 end
 maxt = max(maxt_initial);
end

dt = Time_fill/maxt;                                                                         % Size of the time step 'dt' in seconds

%% CFL values for conjugate heat transfer cases
for i=1:tank_number
if Inner_wall_boundary(i) == 2
CFL_liner(i)= alpha_liner(i)*dt/(dr(i)^2);         % CFL value when properties of the liner is considered             
CFL_laminate(i)= alpha_laminate(i)*dt/(dr(i)^2);   % CFL value when properties of the laminate is considered  
end
end

%% Matrix for various parameters as they vary for each time step

Parameters_for_tank_filling     % Call script that has the parameters for the filling                 

%% Parameters which are constant

% define a working fluid for each tank
for i = 1:tank_number
    inputvalues = importdata(inputFiles{i}, '\t')
    inputdata = inputvalues.data
    
    Working_fluid = inputdata(33)
    if Working_fluid == 1
        Fluid{i} = 'hydrogen';
    elseif Working_fluid == 2
        Fluid{i} = 'methane'
    elseif Working_fluid == 3
        Fluid{i} = 'oxygen'
    end
end

for i = 1:tank_number
    inputvalues = importdata(inputFiles{i}, '\t')
    inputdata = inputvalues.data
    
    a_1 = inputdata(29);      % constant for Nu-Re correlation in zone 1
    b_1 = inputdata(30);        % constant for Nu-Re correlation in zone 1
    
    c_1 = inputdata(31);       % constant for Nu-Re correlation in zone 2
    d_1 = inputdata(32);        % constant for Nu-Re correlation in zone 2
end

J = -2.71;         % constant for the discharge coefficient
I = 0.938;         % constant for the discharge coefficient

%% Inlet temperature and pressure conditions

%Inlet_data  % Call script that contains the inlet boundary conditions


%% Initialisation of the parameters for the fill

Initialisation_tank_filling

%% Computing the filling process

Filling_process                             

%% Plot graphs

plot_graphs % Calls script for displaying plots onscreen, and writing results to .xlsx        
        
end  
    
  







