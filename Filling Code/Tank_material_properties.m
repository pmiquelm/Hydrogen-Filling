%Author(s): Vishagen Ramasamy, Jannic Holzer
%Date: 20/09/2017

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
%accept any responsibility for use of or reliance on results produced by 
%this software.



%%script that inputs tank material properties and determines the thermal
%diffusity of the materials.

%Known properties:
%rho_liner:                 Density of the liner (kg/m^3)
%rho_laminate:              Density of the laminate (kg/m^3)
%cond_liner:                Thermal conductivity of the liner (W/m-K)
%cond_laminate:             Thermal conductivity of the laminate (W/m-K)
%c_liner                    Specific heat of the liner (J/(kg-K))
%c_laminate                 Specific heat of the laminate (J/(kg-K))
%% If PCM is included to the tank(s), the following material properties of
% the PCM are required:
% rho_PCM_solid             Density of the PCM in the solid state (kg/m^3)  
% rho_PCM_liquid            Density of the PCM in the liquid state (kg/m^3)
% rho_PCM_mixture           Density of the PCM in the solid & liquid mixture (kg/m^3)
% cond_PCM                  Thermal conductivity of the PCM (W/m-K)
% c_PCM_solid               Specific heat of the PCM in the solid state (J/(kg-K)) 
% c_PCM_liquid              Specific heat of the PCM in the liquid state (J/(kg-K))
% c_PCM_mixture             Specific heat of the PCM as solid & liquid mixture (J/(kg-K))
% latent_fusion_PCM         Latent heat of fusion of the PCM (J)
% low_melting_temp          Maximum temperature at which the PCM remains as a solid (K)
% high_melting_temp         Minimum temperature at which the PCM becomes liquid (K)
% gradient_enthalpy_temp    Ratio of the Latent heat of fusion of the PCM to the difference between the maximum and minimum temperatures during which transition occurs
% low_melting_enthalpy      Value of the enthalpy at the minimum temperature at which the PCM is still a solid   

if tank_number>1   
    fprintf ('[1] Please check if the material properties for the tanks are similar or different.If different new material properties must be added in script labelled Tank_material_properties.\n')
end

for i=1:tank_number
    rho_liner(i) = inputdata{i}(15);                                                              % Liner density
    rho_laminate(i) = inputdata{i}(16);                                                           % Laminate density
    cond_liner(i) = inputdata{i}(17);                                                              % Liner conductivity
    cond_laminate(i) = inputdata{i}(18);                                                          % Laminate conductivity
    c_liner(i) = inputdata{i}(19);                                                                 % Liner specific heat
    c_laminate(i) = inputdata{i}(20);                                                              % Laminate specific heat
    
    alpha_liner(i) = cond_liner(i)/(rho_liner(i)*c_liner(i));                         % Liner thermal diffusivity
    alpha_laminate(i) = cond_laminate(i)/(rho_laminate(i)*c_laminate(i));             % Laminate thermal diffusivity
    
    if (Inner_wall_boundary(i)== 2 && PCM_inclusion(i) == 2)
        rho_PCM_solid(i) = inputdata{i}(21);                                                                         % Density of the PCM as a solid
        rho_PCM_liquid(i) = inputdata{i}(22);                                                                        % Density of the PCM as a liquid
        rho_PCM_mixture(i) = (rho_PCM_solid(i) + rho_PCM_liquid(i))/2;                                  % Density of the PCM as a mixture of solid and liquid
        cond_PCM(i) = inputdata{i}(23);                                                                             % Thermal conductivity of PCM as a solid
        c_PCM_solid(i) = inputdata{i}(24);                                                                          % Specific heat of the PCM in the solid state
        c_PCM_liquid(i) = inputdata{i}(25);                                                                         % Specific heat of the PCM in the liquid state
        c_PCM_mixture(i) = (c_PCM_solid(i) + c_PCM_liquid(i))/2;                                        % Specific heat of the PCM as solid & liquid mixture
        latent_fusion_PCM(i) = inputdata{i}(26);                                                                  % Latent heat of fusion of the PCM
        low_melting_temp(i) = inputdata{i}(27);                                                                      % Maximum temperature at which the PCM remains as a solid
        high_melting_temp(i) = inputdata{i}(28);                                                                     % Minimum temperature at which the PCM becomes liquid
        gradient_enthalpy_temp(i) = latent_fusion_PCM(i)/(high_melting_temp(i)-low_melting_temp(i));    % Ratio of the Latent heat of fusion of the PCM to the difference between the maximum and minimum temperatures during transition
        low_melting_enthalpy(i) = c_PCM_solid(i)*low_melting_temp(i);                                   % Value of the enthalpy at the minimum temperature at which the PCM is still a solid
    end
end

% for i=2
% 
% rho_liner(i) = 2200;                                           % Liner density
% rho_laminate(i) = 1500;                                        % Laminate density
% cond_liner(i) = 1;                                             % Liner conductivity
% cond_laminate(i) = 1.14;                                       % Laminate conductivity
% c_liner(i) = 576;                                              % Liner specific heat
% c_laminate(i) = 550;                                           % Laminate specific heat
% 
% alpha_liner(i) = cond_liner(i)/(rho_liner(i)*c_liner(i));               % Liner thermal diffusivity
% alpha_laminate(i) = cond_laminate(i)/(rho_laminate(i)*c_laminate(i));   % Laminate thermal diffusivity
% 
% end