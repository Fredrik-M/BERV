n_0 = 10000;
hl = input('Half-life in days: ');
t = input('Number of days to plot: ');

% hl = 3.8;
% t = 10;

T = 0:t;
N = n_0 * exp((-log(2)/hl)*T);

plot(T, N);
xlabel('time (days)');
ylabel('nuclei');