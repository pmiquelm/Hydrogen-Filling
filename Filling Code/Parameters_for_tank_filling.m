%Author(s): Vishagen Ramasamy
%Date: -

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
%accept any responsibility for use of or reliance on results produced by 
%this software.



%%script that preallocates the size the matrix for the various parameters for the filling of
%the tank

for i=1:tank_number 

%% Properties at inlet/exit of the delivery pipe
    
P_inlet = zeros(i,maxt+1);                   % Stagnation pressure at the inlet
Temp_inlet = zeros(i, maxt+1);               % Stagnation temperature at the inlet
rho_exit = zeros(i,maxt+1);                  % Static density at the nozzle exit
vel_exit = zeros(i,maxt+1);                  % Velocity of gas at nozzle exit
h_static_exit = zeros(i,maxt+1);             % Static enthalpy at the nozzle exit
mach_exit = zeros(i,maxt+1);                 % Mach number at nozzle exit
sound_exit = zeros(i,maxt+1);                % Speed of sound at nozzle exit
mfr = zeros(i,maxt+1);                       % Mass flow rate of the gas at the inlet
h_inlet = zeros(i,maxt+1);                   % Specific total inlet enthalpy
entropy_inlet= zeros(i,maxt+1);              % Specific entropy in inlet
visc_exit = zeros(i, maxt+1);                % Dynamic viscosity at nozzle exit
Re_exit_isentropic = zeros(i, maxt+1);       % Reynolds number at nozzle exit
cd = zeros(i, maxt+1);                       % Discharge coefficient at the exit of the delivery pipe
Re_entrance_actual = zeros(i, maxt+1);       % Actual reynolds number at the entrance of the delivery pipe

%% Properties inside of the tank(s)

h_gas = zeros(i, maxt+1);              % Specific total enthalpy of gas in tank
rho_gas = zeros(i, maxt+1);            % Density of gas in tank
m_gas = zeros(i,maxt+1);               % Mass of gas in tank
u_gas = zeros(i, maxt+1);              % Specific internal energy of gas in tank
k_gas = zeros(i, maxt+1);              % Conductivity of gas in tank
P_gas = zeros(i,maxt+1);               % Gas pressure in tank
Temp_gas = zeros(i, maxt+1);           % Gas temperature in tank
Ugas = zeros(i, maxt+1);               % Internal energy of gas in tank

%% Heat variables

Nu_ss = zeros(i, maxt+1);                % Nusselt number steady state
Nu_hys = zeros(i, maxt + 1);             % Nusselt number hysterisis
tau_prod = zeros(i, maxt + 1);
tau_disp = zeros(i, maxt + 1);
tau = zeros(i, maxt + 1);
heat_coef_forced = zeros(i, maxt+1);     % Heat transfer coefficient
Ra = zeros(i, maxt+1);                   % Rayleighs number
beta_gas = zeros(i, maxt+1);             % Coefficient of thermal expansion
cp_gas =  zeros(i, maxt+1);
visc_gas =  zeros(i, maxt+1);
Nu_n = zeros(i, maxt+1);
heat_coef_natural = zeros(i, maxt+1);
heat_coef_total = zeros(i, maxt+1);
Qsurf = zeros(i, maxt+1);                % Heat transfer all the inner wall of the tank(s)

%% Other variables

time = zeros(1,maxt+1);                % Time during  the fill

%% Variables for 2 zone model

if l_d(i) > 3 

Re_compression =  zeros(i, maxt+1);             % Reynolds number for zone 2
    
k_gas_zone1{i} =  zeros(1, maxt+1);             % Conductivity of the gas in zone 1
k_gas_zone2{i} =  zeros(1, maxt+1);             % Conductivity of the gas in zone 2
    
heat_coef_forced_zone1{i} =  zeros(1, maxt+1);  % Conductivity of the gas in zone 1  
heat_coef_forced_zone2{i} =  zeros(1, maxt+1);  % Conductivity of the gas in zone 1 

Nus_zone1{i} =  zeros(1, maxt+1);               % Nusselt number in zone 1 
Nus_zone2{i} =  zeros(1, maxt+1);               % Nusselt number in zone 2

m_gas_zone1{i} = zeros(1, maxt+1);              % Mass of gas in zone 1
m_gas_zone2{i} = zeros(1, maxt+1);              % Mass of gas in zone 2

u_gas_zone1{i} = zeros(1, maxt+1);              % Specific internal energy of gas in zone 1
u_gas_zone2{i} = zeros(1, maxt+1);              % Specific internal energy of gas in zone 2

P_gas_zone1{i} = zeros(1, maxt+1);              % Gas pressure in zone 1
P_gas_zone2{i} = zeros(1, maxt+1);              % Gas pressure in zone 2

Temp_gas_zone1{i} = zeros(1, maxt+1);           % Gas temperature in zone 1
Temp_gas_zone2{i} = zeros(1, maxt+1);           % Gas temperature in zone 1

Qsurf_zone1{i} = zeros(1, maxt+1);              % Heat transfer all the inner wall of zone 1
Qsurf_zone2{i} = zeros(1, maxt+1);              % Heat transfer all the inner wall of zone 2

Ugas_zone1{i} = zeros(i, maxt+1);               % Internal energy of gas in zone 1
Ugas_zone2{i} = zeros(i, maxt+1);               % Internal energy of gas in zone 2

rho_gas_zone1{i} = zeros(i, maxt+1);             % Density of gas in zone 1  
rho_gas_zone2{i} = zeros(i, maxt+1);             % Density of gas in zone 2

P_ratio{i} = zeros(1, maxt+1);                  % Pressure ratio of zone 1 & zone 2
end

end








