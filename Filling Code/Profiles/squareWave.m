function profile = squareWave(input, PInitial)

amplitude = input(1);
period = input(2);
duty = input(3);
slope = input(4);

x = linspace(0,90,100000);

y = amplitude * square((1/period) * 2 * pi .* x, duty) + slope .* x;
y(y < PInitial) = PInitial;

profile = [x;y]';
end