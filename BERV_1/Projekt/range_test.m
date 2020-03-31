d = 25;
rg = range(d, 'roadster.mat', 'speed_elsa.mat', 10000, 100);
disp(['Battery charge expected being enough for driving ', num2str(rg), 'km.']);
% Battery charge expected being enough for driving 49.6698 km.
rg = range(d, 'roadster.mat', 'speed_anna.mat', 2000, 100);
disp(['Battery charge expected being enough for driving ', num2str(rg), 'km.']);
% varningsmeddelande: batterin är slut eller error