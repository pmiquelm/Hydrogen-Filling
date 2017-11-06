%% script that discretizes the structure of the tank(s)

for i=1:tank_number

dr(i) = 2.5e-04;                                                               % grid spacing for tank wall
number_of_gridpoints(i) = round((Wall_thickness_total(i))/dr(i) +1);           % Number of grid points across tank(s) wall

if (Inner_wall_boundary(i)== 2 && PCM_inclusion(i) == 2)
int_pt_liner_PCM(i) = liner_thickness(i)/dr(i) + 1 ;                           % grid point at interface between liner and PCM
int_pt_PCM_laminate(i) = (liner_thickness(i)+PCM_thickness(i))/dr(i) + 1 ;     % grid point at interface between PCM and laminate
else
int_pt_liner_laminate(i) = liner_thickness(i)/dr(i) + 1 ;                      % grid point at interface between liner and laminate
end
end