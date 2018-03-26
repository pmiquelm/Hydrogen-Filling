%Author: Pau Miquel Mir
%Date: 07/11/2017

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
% accept any responsibility for use of or reliance on results produced by 
% this software.

for i = 1:tank_number

% pressureDifference = diff(P_gas(i,1:maxt+1));
% index = find(pressureDifference < 0.001, 1);
% fillTime = time(index)

fillTime = time(find(P_gas>=69999,1))

maxTempGas = max(Temp_gas_C(i,1:maxt+1));
maxTempLiner = max(Temp_wall{i}(1,1:maxt+1)) - 273;
maxTempLaminate = max(Temp_wall{i}(int_pt_liner_laminate(1) + 1,1:maxt+1)) - 273;

maxTempToOptimize = maxTempGas - 85
ceq = [];

end