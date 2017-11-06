%Author: Vishagen Ramasamy

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
%accept any responsibility for use of or reliance on results produced by 
%this software.

%% Inlet pressure and temperature data from Dicken and Merida (2007).  
%% The pressure profile at the inlet is curve-fitted and constants used are as follows: 

A = 9.36e+03;
B = 3.43e+03;
C = 1.21e+02;
D = -5.29e+02;
E = 1.1829e+04;
F = 1.01e+03;
G = 112e-03;
H = -1.44e+01;

%% The temperature profile at the inlet is read from an excel spreadsheet

data_temp_in = xlsread('Inlet_temperature_profile_Dicken_and_Merida.xlsx');

time_in = data_temp_in(:,1);

temp_in = data_temp_in(:,3);

