d = 5:10:65;
N = [10 100 1000 1e04];
anna = load('speed_anna.mat');
elsa = load('speed_elsa.mat');

for n=N
    T = time_to_destination(40, 'speed_anna.mat', n);
    Tint = integral(@(z) 1./velocity(z, 'speed_anna.mat'), 0, 40);
    disp(['Approx. on ', num2str(n), ' intervals = ', datestr(hours(T),'HH:MM:SS')]);
    disp(['Matlab integral = ', datestr(hours(Tint),'HH:MM:SS')]);
    disp(' ');
end

% Approx. on 10 intervals = 00:44:59
% Matlab integral = 00:24:58%  

% Approx. on 100 intervals = 00:26:21
% Matlab integral = 00:24:58%  

% Approx. on 1000 intervals = 00:25:13
% Matlab integral = 00:24:58%  

% Approx. on 10000 intervals = 00:24:58
% Matlab integral = 00:24:58

T = time_to_destination(0, 'speed_elsa.mat', 1e03)
% 0
T = time_to_destination(70, 'speed_elsa.mat', 1e03)
% error
T = time_to_destination(-10, 'speed_elsa.mat', 1e03)
% error