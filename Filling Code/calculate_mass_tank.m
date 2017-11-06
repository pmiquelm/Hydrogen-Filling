function mass_tank = calculate_mass_tank(i, r_tank, rho_liner, rho_laminate,liner_thickness, Wall_thickness_total,l_tank_straight)
% Function that finds the structural mass of the tanks
%
% Inputs:
%tank_number                                                         Number of tanks being filled
%r_tank:                                                             Radius of tank (m)
%rho_liner(i):                                                       Density of the liner (kg/m^3)
%rho_laminate(i):                                                    Density of the laminate (kg/m^3)
%liner_thickness:                                                    Thickness of liner (m)
%laminate_thickness:                                                 Thickness of laminate (m)
%Wall_thickness_total:                                               Total thickness of the tank wall(m)
%l_tank_straight:                                                    Length of middle portion of tank without dome (m)
%
%If PCM is included, the following inputs are required:
%
%PCM:                                                                Presence of PCM as part of the structure of the tank(s)
%Inner:                                                              Conjugate heat transfer case 
%rho_PCM:                                                            Density of the PCM (kg/m^3)  
%PCM thickness:                                                      Thickness of the PCM (m)
%
% Outputs:
% mass of tank(s):                                                   Structural mass of tank(s) (kg)

 
 mass_liner_dome =  4/3*pi*((r_tank(i)+liner_thickness(i))^3-r_tank(i)^3)*rho_liner(i);
 mass_liner_straight_portion = pi*((r_tank(i)+liner_thickness(i))^2-r_tank(i)^2)*l_tank_straight(i)*rho_liner(i);
 mass_laminate_dome = 4/3*pi*((r_tank(i)+Wall_thickness_total(i))^3-(r_tank(i)+liner_thickness(i))^3)*rho_laminate(i);
 mass_laminate_straight_portion = pi*((r_tank(i)+Wall_thickness_total(i))^2-(r_tank(i)+liner_thickness(i))^2)*l_tank_straight(i)*rho_laminate(i); 
 mass_PCM_dome = 0;
 mass_PCM_straight_portion = 0;
 mass_tank = mass_liner_dome+mass_liner_straight_portion+mass_laminate_dome+mass_laminate_straight_portion+mass_PCM_dome+mass_PCM_straight_portion;
end
