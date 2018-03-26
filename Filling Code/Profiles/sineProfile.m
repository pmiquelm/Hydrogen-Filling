function profile = sineProfile(input, PInitial)

height = input(1);
period = input(2);
slope = input(3);

x = linspace(0,60,100000);

y = 0.5 * height * sin((1/period) * 2 * pi .* x) + slope .* x + 0.5 * height;

y(y < PInitial) = PInitial;

profile = [x;y]';

end