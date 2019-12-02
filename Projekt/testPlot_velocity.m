d = [1 14.5 3.14 20.67 35 56 42.1 59 9.5];

plot_route_anna
hold on
scatter(d, velocity(d, 'speed_anna.mat'), 'b');

% for i = 1:length(d)
%     s = velocity(d(i), 'speed_anna.mat');
%     scatter(d(i), s, 'b');
% end