% Plots bifurcation diagram of the logistic map

mu = [2:0.0125:3.8];
q  = 128;
x_ = 0.5;

% =======================================================================

plot(mu, 1 - mu.^(-1), '--k');
hold;

poMat = zeros(q+1, length(mu));
for i = 1:length(mu)
    f  = @(x)logistic(x, mu(i));
    df = @(x)dLogistic(x, mu(i));
    poMat(:,i) = pOrbit(f, df, x_, q, 0.000125);
end

for i = 1:size(poMat, 1)
    scatter(mu, poMat(i,:), '.b');
end

title(sprintf('Bifurcation diagram of logistic map, periods \x2264 %i', q));
xlabel(sprintf('\x03bc'));
ylabel('x^*');
legend(sprintf('1 - \x03bc^{-1}'), 'location','northwest');