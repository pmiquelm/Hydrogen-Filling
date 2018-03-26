function profile = linearRamp(slope, PInitial)

disp(["Slope: " slope])

time  = round(70 / slope * 1.1);

profile = [ [0:time] ; (slope .* [0:time]) .* 1000 +  PInitial]' ;

end