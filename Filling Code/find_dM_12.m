%Author: Vishagen Ramasamy
%Date: -

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
%accept any responsibility for use of or reliance on results produced by 
%this software.

function dM_12 = find_dM_12(h,V,M,U,Fluid,dM_guess, refpropdir)
% Function that finds the amount of mass we need to transfer from zone 1 to
% zone 2 in order to equalise the pressure in these two zones.
%
% Inputs:
% h:        specific enthalpy vector (kJ/kg or J/kg??)
% V:        Volume vector (m^3)
% M:        Mass vector (kg)
% U:        Internal energy vector (kJ or J??)
% dM_guess: initial guess for the amount of mass transferred (kg).
%
% Outputs:
% dM_guess: Mass transferred from zone 1 to zone 2 to equalise pressure
%           (kg).

% fzero is a non-linear root finder that searches for the value of dM_12
% that returns dP=0
[dM_12] = fzero(@find_dP,dM_guess); 
   
    function dP=find_dP(dM_guess)
        % Function that finds the pressure difference following transfer of
        % an amount dM_guess of mass from zone 1 to zone 2. 
        %
        % Inputs:
        % dM_guess: amount of mass transferred that will be tested (kg).
        % N.B. Other variables passed to the find_dM_12 function are also
        % available in here.
        % 
        % Outputs:  
        % dP:       the resulting pressure difference after transferrring
        %           dM_guess of fluid. (kPa?? or MPa??)
        dM(1)=-dM_guess; % mass in zone 1 decreases
        dM(2)= dM_guess; % mass in zone 2 increases

        % if dM_guess is positive then we have flow from 1 in to 2,
        % otherwise we set dM_1_into_2 to zero
        dM_1_into_2(1)=min(0,-dM_guess); 
        dM_1_into_2(2)=max(0, dM_guess);

        % if dM_guess is negative then we have flow from 2 in to 1,
        % otherwise we set dM_2_into_1 to zero
        dM_2_into_1(1)=max(0,-dM_guess);
        dM_2_into_1(2)=min(0, dM_guess);
        
        for i=1:2
            x = U(i);
            M_loc=M(i)+dM_1_into_2(i)+dM_2_into_1(i);           % find the new mass
            U_loc=U(i)+h(1)*dM_1_into_2(i)+h(2)*dM_2_into_1(i); % find the new internal energy
            rho_loc=M_loc/V(i);                                 % find the new density
            u_spec=U_loc/M_loc;                                 % find the new specific internal energy
            P(i)=refpropm('P','D',rho_loc,'U',u_spec,Fluid, refpropdir);    % find the new pressure
        end
        dP=P(2)-P(1);                                           % find the difference in pressure between the two zones.
    end
end