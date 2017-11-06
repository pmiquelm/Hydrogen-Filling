function maxt=calculate_maxtpcm(i,CFL, a_liner, a_laminate,dr,Time_fill,rho_PCM_solid,rho_PCM_liquid,cond_PCM,c_PCM_liquid,c_PCM_solid)
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

 dt_guess_liner = CFL*(dr(i))^2/a_liner(i);                                                                               % Initial  value of dt for the stability during the compuation of heat transfer across the liner 
 dt_guess_laminate = CFL*dr(i)^2/a_laminate(i);                                                                           % Initial  value of dt for the stability during the compuation of heat transfer across the laminate
 dt_guess_PCM = CFL*(dr(i))^2*min(rho_PCM_solid(i),rho_PCM_liquid(i))*min(c_PCM_solid(i),c_PCM_liquid(i))/(cond_PCM(i));
 minimum_dt_guess_NO_PCM = min(dt_guess_liner,dt_guess_laminate);                                                         % Minimum value of dt from the above values
 minimum_dt_guess = min(minimum_dt_guess_NO_PCM,dt_guess_PCM); 
 dt_conjugate = fix(minimum_dt_guess/10^floor(log10(minimum_dt_guess)))*10^floor(log10(minimum_dt_guess));                % The value of dt is rounded down to a single significant figure
 dt_initial = min(dt_conjugate);                                                                                          % The minimum value of dt is determined if more than 1 tank is being filled and the tanks have different material properties 
 maxt = ceil(Time_fill/dt_initial);                                                                                       % The number of time steps is determined as an integer  



end