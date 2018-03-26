%Author: Pau Miquel, Vishagen Ramasamy, Jannic Holzer
%Date: 20/09/2017

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
%accept any responsibility for use of or reliance on results produced by 
%this software.



%%

function [fillTime,maxTempToOptimize,avgHeatCoef] = MainRoutine(x0, profileFunction, ...
    inputFiles, blnOneZone, blnThrottling, blnConstMassFlow, constMassFlow, ...
    blnGraph, OutputFolder, OutputPrefix, refpropdir)

 
close;  % Closes any figures that are still open

if nargin < 11
    refpropdir = "";
end

if nargin < 9
    OutputFolder = pwd; 
    OutputPrefix = 'Test_';
end

if nargin < 8
    blnGraph = 0;
end

if nargin < 6
    blnConstMassFlow = 0;
end

if nargin < 5
    blnThrottling = 0;
end

if nargin < 4
    blnOneZone = {1};
end

if nargin < 3
    inputFiles = "/Users/Pau/Desktop/Individual_Project/Hydrogen Filling/Examples/InputFiles/HydrogenExample.dat";
end
    
blnUseProfile = 1;

% Get number of tanks to run simulation for
tank_number = size(inputFiles, 1);

for i=1:tank_number
    inputvalues = importdata(inputFiles{i}, '\t');
    inputdata{i} = inputvalues.data;
end

inputFileNames = [];
for inputFile=inputFiles.'
    inputFileArray = strsplit(inputFile, "/");
    inputFileNames = [inputFileNames inputFileArray(end)];
end

PInitial = inputdata{1}(4) * 100;

InletPressureData = profileFunction(x0, PInitial);

%% Select whether conjuagte heat transfer or isothermal inner boundary conditions of the tank(s)
% If conjugate heat transfer is selected, the outer wall boundary
% conditions must be selected as either isothermal or adiabatic
for i=1:tank_number
%     inputvalues = importdata(inputFiles{i}, '\t');
%     inputdata = inputvalues.data;
    Inner_wall_boundary(i) = inputdata{i}(1); % 1 => isothermal, 2 => conjugate
    if Inner_wall_boundary(i)== 2
        PCM_inclusion(i) =  inputdata{i}(2); %1 => no PCM inclusion, 2 => PCM inclusion
        Outer_wall_boundary(i) = inputdata{i}(3); %1 => isothermal, 2 => adiabatic
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
if blnUseProfile == 1
    Time_fill = InletPressureData(end,1);          % Fill time in seconds
else
    Time_fill = 5;
end

%% Determining the miniumum number of time steps (maxt) required for the compuation of heat transfer across the structure
% The explicit method is used to compute the heat transfer across the
% structure of the cylinder and for stability, the CFL must be less than 0.5

CFL = 0.5;
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
    Working_fluid = inputdata{i}(33);
    if Working_fluid == 1
        Fluid{i} = 'hydrogen';
    elseif Working_fluid == 2
        Fluid{i} = 'methane';
    elseif Working_fluid == 3
        Fluid{i} = 'oxygen';
    end
end

for i = 1:tank_number
    a_1 = inputdata{i}(29);      % constant for Nu-Re correlation in zone 1
    b_1 = inputdata{i}(30);        % constant for Nu-Re correlation in zone 1
    
    c_1 = inputdata{i}(31);       % constant for Nu-Re correlation in zone 2
    d_1 = inputdata{i}(32);        % constant for Nu-Re correlation in zone 2
end

J = -2.71;         % constant for the discharge coefficient
I = 0.938;         % constant for the discharge coefficient

%% Initialisation of the parameters for the fill

Initialisation_tank_filling

%% Computing the filling process

Filling_process                             

%% Plot graphs
if blnGraph
    plot_graphs % Calls script for displaying plots onscreen, and writing results to .xlsx           
end
%% Fill Time and Max Temps

FillTimeAndMaxTemp

end
