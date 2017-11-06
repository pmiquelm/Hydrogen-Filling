%Author: Vishagen Ramasamy
%Date: -

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
%accept any responsibility for use of or reliance on results produced by 
%this software.

function P_exit = find_exit_pressure(h,s,Fluid,P_guess, refpropdir)
% Function that determines the exit pressure during choking conditions at
% the exit of the delivery pipe
%
% Inputs:
% h:        specific enthalpy vector (J/kg)
% s:        specific entropy (J/(kg-K))
% Fluid:    Fluid under consideration
% P_guess:  initial guess of the exit pressure (KPa).
%
% Outputs:
% exit pressure: pressure at the exit of the delivery pipe such that the Mach
% number is equal to one

% fzero is a non-linear root finder that searches for the value of dM
% that returns dM=0
[P_exit] = fzero(@find_dM,P_guess); 
   
    function dM=find_dM(P_guess)
        % Function that finds the pressure at the exit of the delivery pipe  
        % such that the exit Mach number is equal to one when choking
        % occurs at the exit
        % Inputs:
        % P_guess: Pressure at the exit will tested (KPa).
        % N.B. Other variables passed to the find_dM function are also
        % available in here.
        % 
        % Outputs:  
        % dM:Difference between one and the exit Mach number

        
     h_static = refpropm('H','P',P_guess,'S',s,Fluid, refpropdir);     % Returns the static enthalpy at the exit of nozzle
     sound_speed = refpropm('A','P',P_guess,'S',s,Fluid, refpropdir);  % Returns the speed of sound at the exit of nozzle  
     M = sqrt(2*(h-h_static)/(sound_speed)^2);             % Calcutes the Mach number at the exit of nozzlee
        
     dM=1-M;                                                % find the difference in Mach number and one.
     
     
    end
end