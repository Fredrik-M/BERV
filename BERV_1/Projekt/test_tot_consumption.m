N = 80;
d = 25;
tot = tot_consumption(d, 'roadster.mat', 'speed_anna.mat', N);
% compare with expected consumption from Matlab integration
fconso = @(z) consumption(velocity(z, 'speed_anna.mat'), 'roadster.mat'); 
Eint = integral(fconso, 0, d);
disp(['Approx. on ', num2str(N), ' intervals = ', num2str(tot)]);
disp(['Matlab integral = ', num2str(Eint)]);
disp(' ')
% Approx. on 80 intervals = 3934.4427
% Matlab integral = 3928.5517
tot = tot_consumption(d, 'roadster.mat', 'speed_elsa.mat', N);
fconso = @(z) consumption(velocity(z, 'speed_elsa.mat'), 'roadster.mat'); 
Eint = integral(fconso, 0, d);
disp(['Approx. on ', num2str(N), ' intervals = ', num2str(tot)]);
disp(['Matlab integral = ', num2str(Eint)]);
disp(' ')
% Approx. on 80 intervals = 3352.4328
% Matlab integral = 3345.5727

tc = tot_consumption(d, 'roadster.mat', 'speed_anna.mat', 33)
% error pga antalet intervaller eller automatisk korrigering
tc = tot_consumption(-2, 'roadster.mat', 'speed_anna.mat', 100)
% error
