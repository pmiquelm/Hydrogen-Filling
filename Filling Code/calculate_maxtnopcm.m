function maxt = calculate_maxtnopcm(i, CFL, a_liner, a_laminate, Inner_wall_boundary,dr,Time_fill)
%% Funtion that determines the size of the time step such that stability of the explicit formulation of heat transferis achived
%
% Inputs:
%tank number:                 Number of tanks being filled
%Inner wall boundary:         Either isothemal inner wall boundary conditions or conjugate heat transfer
%dr:                          Size of the discretization of the structure of the cylinder in m
%a_liner:                     Thermal diffusivity of the liner in m^2/s
%a_laminate                   Thermal diffusivity of the laminate m^2/s
% Outputs:
%Maxt:                        Minimum number of time steps that is required 

if max(Inner_wall_boundary(i)) >1 
dt_guess_liner = CFL*(dr(i))^2/a_liner(i);                                                                      % Initial  value of dt for the stability during the compuation of heat transfer across the liner 
dt_guess_laminate = CFL*dr(i)^2/a_laminate(i);                                                                  % Initial  value of dt for the stability during the compuation of heat transfer across the laminate
minimum_dt_guess = min(dt_guess_liner,dt_guess_laminate);                                                       % Minimum value of dt from the above values
dt_conjugate = fix(minimum_dt_guess/10^floor(log10(minimum_dt_guess)))*10^floor(log10(minimum_dt_guess));       % The value of dt is rounded down to a single significant figure
dt_initial = min(dt_conjugate);                                                                                 % The minimum value of dt is determined if more than 1 tank is being filled and the tanks have different material properties 
maxt = ceil(Time_fill/dt_initial);                                                                              % The number of time steps is determined as an integer  
else  
maxt = Time_fill*10;                                                                                            % If no conjugate heat tranfer is being considered larger values of the time step can be used                                                                                                  
end


end
