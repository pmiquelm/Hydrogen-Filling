%Author: Vishagen Ramasamy, Jannic Holzer
%Date: 20/09/2017

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
%accept any responsibility for use of or reliance on results produced by 
%this software.

%script that inputs tank dimensions and determines the diameter and inner 
%surface area of tank. For cylinders having a length-to-diameter ratios
%greater than three, the tank is divided into 2 zones.
%
%Known dimensions:
%d_inlet:               Inlet diameter (m)
%l_pipe_inlet:          Pipe length protruding into the tank (m)
%vol_inlet:             Volume of pipe protruding into the tank (m^3)
%A_inlet:               Cross-sectional area of the inlet (m^2)
%vol_tank:              Volume of the tank (m^3)
%liner_thickness:       Thickness of liner (m)
%laminate_thickness:    Thickness of laminate (m)
%l_d:                   length-to-diameter ratio of the tank
%tank_number            Number of tanks being filled
%PCM thickness          If a PCM is included as part of the structure of the tank(s), the thickness of the PCM is required (m)
%
%
%Outputs:
%r_tank:                 Inner radius of tank (m)
%d_tank:                 Inner diameter of tank (m)
%l_tank:                 Length of inner portion of the tank (m)
%Wall_thickness_total    Total thickness of the tank wall(m)
%l_tank_straight         Length of middle portion of tank without dome (m)
%surface_area            Surface area of inner part of tank (m^2)
%l_zone1_pipe_exit       Length of zone 1 from the exit of the pipe (m)
%l_zone1_total           Length of zone 1 from the front of the tank (m)
%l_zone1_straight        Length of zone 1 along the straight portion of the tank (m)
%l_zone2_total           Length of zone 2 (m)
%l_zone2_straight        Length of zone 2 along the straight portion of the tank (m)
%surface_area_zone1      Surface area of zone 1 (m^2)
%surface_area_zone2      Surface area of zone 2 (m^2)
%volume_zone1            Volume of zone 1 (m^2)
%volume_zone2            Volume of zone 2 (m^2)

for i = 1:tank_number
    
    d_inlet = inputdata{i}(8);                   % Inlet diameter (m)
    l_pipe_inlet = inputdata{i}(9);              % length of pipe protruding into the tank (m)
    A_inlet = (pi*d_inlet^2)/4 ;                % Cross-sectional area of the inlet (m^2)
    vol_inlet = A_inlet * l_pipe_inlet;         % volume of inlet tube (m^3)
    
    vol_tank(i) = inputdata{i}(10);                 % Volume of the tank (m^3)
    liner_thickness(i) = inputdata{i}(11);          % Thickness of liner (m)
    laminate_thickness(i) = inputdata{i}(12);       % Thickness of laminate (m)
    l_d(i) = inputdata{i}(13);                      % length-to-diameter ratio of the tank
end


for i=1:tank_number
if (Inner_wall_boundary(i)== 2 && PCM_inclusion(i) == 2)
PCM_thickness(i) = inputdata{i}(14);                                       % Inclusion of the thickness of the PCM
else
PCM_thickness(i) =0;                                           % No PCM is included   
end
end
    
if tank_number > 1   
    fprintf ('[2] Volume, length-to-diameter ratio, liner and laminate thickness of additional tanks must be added in script Tank_dimension\n')
end

for i=1:tank_number
    if l_d(i) < 3
        l_d(i) = 3;                                                                                  % Fixing the length to diameter ratio to create an inner surface area that corresponds to a cylinder with L/D of 3
    end
    if (Inner_wall_boundary(i)== 2 && PCM_inclusion(i) == 2)
    Wall_thickness_total(i) = liner_thickness(i)+laminate_thickness(i)+PCM_thickness(i);             % Total thickness of the tank(s) wall(m) with PCM as part of the structure
    else
    Wall_thickness_total(i) = liner_thickness(i)+laminate_thickness(i)+PCM_thickness(i);             % Total thickness of the tank(s) wall(m) without PCM as part of the structure    
    end
    r_tank(i)=(vol_tank(i)/(pi*(4/3+2*(l_d(i)-1))))^(1/3);                                           % Inner radius of tank (m)
    d_tank(i) = 2*r_tank(i);                                                                         % Inner diameter of tank (m)
    l_tank(i) = l_d(i)*(d_tank(i));                                                                  % Length of inner portion of the tank (m)
    l_tank_straight(i) = l_tank(i)-(d_tank(i));                                                      % Length of middle portion of tank without dome (m)
    surf_area(i) = (2*pi*r_tank(i)*l_tank_straight(i))+(4*pi*r_tank(i)^2)- A_inlet;                  % Surface area of inner part of tank (m^2)
    
%% Calculations of the geometry of zone 1 and zone 2 when l/d of cylinder is greater than 3

if l_d(i)>3    

l_zone1_pipe_exit(i) = d_tank(i)*3.1;                                                                % Length of zone 1 from the exit of the pipe (m)
l_zone1_total(i) = l_zone1_pipe_exit(i) + l_pipe_inlet;                                              % Length of zone 1 from the front of the tank (m)
l_zone1_straight(i) = l_zone1_total(i) - (d_tank(i)/2);                                              % Length of zone 1 along the straight portion of the tank (m)
surface_area_zone1(i) = (4*pi*r_tank(i)^2)/2-A_inlet+(2*pi*r_tank(i)*l_zone1_straight(i));           % Surface area of zone 1 (m^2)
volume_zone1(i) = (0.5*4/3*pi*r_tank(i)^3 + pi* r_tank(i)^2*l_zone1_straight(i))- vol_inlet;         % Volume of zone 1 (m^2)


l_zone2_total(i) = (l_tank(i) - l_zone1_total(i));                                                   % Length of zone 1 from the front of the tank (m)
l_zone2_straight(i) = l_zone2_total(i) - r_tank(i);                                                  % Length of zone 2 along the straight portion of the tank (m)
surface_area_zone2(i) = (2*pi*r_tank(i)*l_zone2_straight(i)) + (4*pi*r_tank(i)^2)/2;                 % Surface area of zone 2 (m^2)
volume_zone2(i) = 0.5*4/3*pi*r_tank(i)^3 + pi* r_tank(i)^2*l_zone2_straight(i);                      % Volume of zone 2 (m^2)

end
end