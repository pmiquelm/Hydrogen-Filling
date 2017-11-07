%Author: Vishagen Ramasamy, Jannic Holzer
%Date: 20/09/2017

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
%accept any responsibility for use of or reliance on results produced by 
%this software.

%%script that initialises the various parameters for the filling of
%the tank(s)

for i=1:tank_number
    for j=1
        
        %% Properties inside of the tank(s)(s)
        
        inputvalues = importdata(inputFiles{i}, '\t');
        inputdata = inputvalues(:, 1).data;
        
        P_gas(i,j) = inputdata(4) * 100;                                                     % Initial gas pressure in tank(s) in KPa
        Temp_gas(i,j) = inputdata(5) + 273.15;                                                  % Initial gas temperature in tank(s)(s) in K
        h_gas(i,j) = refpropm('H','T',Temp_gas(i,j),'P',P_gas(i,j),Fluid{i}, refpropdir);              % Initial specific total enthalpy of gas in tank(s)(s) in J/kg
        rho_gas(i,j) = refpropm('D','T',Temp_gas(i,j),'P',P_gas(i,j),Fluid{i}, refpropdir);            % Initial density of gas in tank(s)(s) in kg/m^3
        m_gas(i,j) = rho_gas(i,j)*vol_tank(i);                                          % Initial dass of gas in tank(s) in kg
        u_gas(i,j) = refpropm('U','T',Temp_gas(i,j),'P',P_gas(i,j),Fluid{i}, refpropdir);              % Initial specific internal energy of gas in tank(s) in J/kg
        k_gas(i,j) = refpropm('L','T',Temp_gas(i,j),'P',P_gas(i,j),Fluid{i}, refpropdir);              % Initial thermal conductivity of gas in tank(s) in W/(m-K)
        Ugas(i,j) = m_gas(i,j)*u_gas(i,j);                                              % Initial internal energy of gas in tank(s) in J
        
        %% Properties at inlet/exit of the delivery pipe
        P_inlet(i,j) = inputdata(4) * 100;                                                   % Initial stagnation pressure at the inlet in KPa
        Temp_inlet(i,j) = inputdata(5) + 273.15;                                                % Initial gas temperature at the inlet in K
        rho_exit(i,j) = refpropm('D','T',Temp_gas(i,j),'P',P_gas(i,j),Fluid{i}, refpropdir);           % Static density at the nozzle exit
        P_static_exit(i,j) = P_gas(i,j);                                                % Initial  static pressure at the nozzle exit in KPa
        vel_exit(i,j) = 0 ;                                                 % Initial velocity of gas at nozzle exit in m/s
        h_static_exit(i,j) = refpropm('H','T',Temp_gas(i,j),'P',P_gas(i,j),Fluid{i}, refpropdir);      % Initial static enthalpy at the nozzle exit in J/kg
        mach_exit(i,j) = 0 ;                                                % Initial Mach number at nozzle exit
        sound_exit(i,j) = refpropm('A','T',Temp_gas(i,j),'P',P_gas(i,j),Fluid{i}, refpropdir);         % Initial speed of sound at nozzle exit in m/s
        mfr(i,j) = 0;                                                       % Initial mass flow rate of the gas at the inlet in kg/s
        h_inlet(i,j) = refpropm('H','T',Temp_inlet(i,j),'P',P_inlet(i,j),Fluid{i}, refpropdir);        % Initial specific total inlet enthalpy in J/kg
        entropy_inlet(i,j) = refpropm('S','T',Temp_inlet(i,j),'P',P_inlet(i,j),Fluid{i}, refpropdir);  % Initial specific entropy in inlet in J/(kg-K)
        visc_exit(i,j) = refpropm('V','T',Temp_gas(i,j),'P',P_gas(i,j),Fluid{i}, refpropdir);          % Initial dynamic viscosity at nozzle exit in Pa*s
        Re_exit_isentropic(i,j) = 0;                                        % Initial isentropic Reynolds number at nozzle exit
        cd(i,j) = 0;                                                        % Initial discharge coefficient at the exit of the delivery pipe
        Re_entrance_actual(i,j) = 0;                                        % Initial actual reynolds number at the entrance of the delivery pipe
        
    end
    
    %% Intialisation of the temperature of tank(s) wall across the thickness for conjugate case
    if Inner_wall_boundary(i) == 2
        grid_points = number_of_gridpoints(i);    % Setting a scalar for the number of grid points across the thickness of the structure of the tank(s)
        
        Temp_wall{i} = zeros(grid_points,maxt+1); % Pre-allocating the size of the matrix that will be used to determine the temperature of the structure across its thickness
        r{i} = zeros(1,grid_points);              % Discretization of the structure of the cylinder across the liner and laminate
        
        for j = 1:grid_points
            
            r{i}(j) = (j-1)*dr(i);                % Setting grid point locations across the thickness of liner and laminate
            Temp_wall{i}(j) = inputdata(6) + 273.15;            % Initial temperature for tank(s) wall
            
        end
        
        Temp_wall_zone1{i} = zeros(grid_points,maxt+1);       % Pre-allocating the size of the matrix that will be used to determine the temperature of the structure across its thickness in zone 1
        Temp_wall_zone2{i} = zeros(grid_points,maxt+1);       % Pre-allocating the size of the matrix that will be used to determine the temperature of the structure across its thickness in zone 2
        
        for j= 1:grid_points
            
            Temp_wall_zone1{i}(j) = inputdata(6) + 273.15;         % Initial temperature for tank(s) wall in zone 1
            Temp_wall_zone2{i}(j) = inputdata(6) + 273.15;         % Initial temperature for tank(s) wall in zone 1
            
        end
    end
    %% Heat variables
    
    for j=1
        Nus(i,j) = 0;                  % Initial Nusselt number
        heat_coef_forced(i,j) = 0;     % Intial heat transfer coefficient in W/(m^2-K)
        Qsurf(i,j) = 0;                % Initial amount heat transfer across the inner wall of the tank(s) in J
    end
    %% Other variables
    time(i) = 0;                   % Intial Time
    
    %% Variables for 2 zone model

    if l_d(i) > 3 && blnOneZone{i} == 0
        
        Re_circulation(i) =0;                                      % Reynolds number for zone 2
        Re_compression(i) =0;                                      % Reynolds number for zone 2
        
        for j=1
            P_gas_zone1{i}(j) = P_gas(i,j);                            % Initial gas pressure in zone 1
            P_gas_zone2{i}(j) = P_gas(i,j);                            % Initial gas pressure in zone 2
            
            Temp_gas_zone1{i}(j) = Temp_gas(i,j);                      % Initial gas temperature in zone 1
            Temp_gas_zone2{i}(j) = Temp_gas(i,j);                      % Initial gas temperature in zone 1
            
            k_gas_zone1{i}(j) =  k_gas(i,j);                           % Initial conductivity of the gas in zone 1
            k_gas_zone2{i}(j) =  k_gas(i,j);                           % Initial conductivity of the gas in zone 2
            
            heat_coef_forced_zone1{i}(j) =  0;                         % Conductivity of the gas in zone 1
            heat_coef_forced_zone2{i}(j) =  0;                         % Conductivity of the gas in zone 1
            
            Nus_zone1{i}(j) =  0;                                      % Initial nusselt number in zone 1
            Nus_zone2{i}(j) =  0;                                      % Initial nusselt number in zone 2
            
            rho_gas_zone1{i}(j) = rho_gas(i,j);                        % Density of gas in zone 1
            rho_gas_zone2{i}(j) = rho_gas(i,j);                        % Density of gas in zone 2
            
            m_gas_zone1{i}(j) = rho_gas_zone1{i}(j)*volume_zone1(i);    % Initial mass of gas in zone 1
            m_gas_zone2{i}(j) = rho_gas_zone2{i}(j)*volume_zone2(i);    % Initial mass of gas in zone 2
            
            u_gas_zone1{i}(j) = u_gas(i,j);                            % Initial specific internal energy of gas in zone 1
            u_gas_zone2{i}(j) = u_gas(i,j);                            % Initial specific internal energy of gas in zone 2
            
            Ugas_zone1{i}(j) = m_gas_zone1{i}(j)*u_gas(i,j);           % Initial internal energy of gas in zone 1
            Ugas_zone2{i}(j) = m_gas_zone2{i}(j)*u_gas(i,j);           % Initial internal energy of gas in zone 2
            
            Qsurf_zone1{i}(j) = 0;                                     % Initial heat transfer all the inner wall of zone 1
            Qsurf_zone2{i}(j) = 0;                                     % Initial heat transfer all the inner wall of zone 2
            
            P_ratio{i}(j) = 1;                                   % Initial pressure ratio of zone 1 & zone 2
        end
    end
    %% Inner wall temperature for isothermal inner wall conditions
    if Inner_wall_boundary(i) == 1
        Inner_temp_wall_isothermal(i) = inputdata(6) + 273.15;
    end
    
    %% Outer wall temperature for isothermal outer wall conditions
    if Inner_wall_boundary(i) == 2
        if Outer_wall_boundary(i) == 1
            Outer_temp_wall_isothermal(i) = inputdata(7) + 273.15;
        end
    end
end