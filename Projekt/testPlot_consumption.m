s = [1 14.7 35 19 3.14 100 102 42 220];
c = consumption(s, 'roadster.mat');

plot_roadster_consumption
hold on
scatter(s, c, 'b')