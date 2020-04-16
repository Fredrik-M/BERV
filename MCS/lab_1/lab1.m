% Plots y = x, y = (f_mu)^n(x), ..., y = (f_mu)^m(x), where (f_mu)^k is the
% k:th iteration of the logistic map with parameter mu.

mu = 2.5;
x  = linspace(0, 1, 101);
n = 1;
m = 4;

% =======================================================================

Omat = orbit(@(x)logistic(x, mu), x, m);
p = zeros(1, 1 + size(Omat, 1));
p(1) = plot(x, Omat(1,:), 'k');
hold;
for i = n + 1:m + 1
    c = 1/255.*[mod(5 + 30 * (i-1),255), 5, mod(255 - 30 * (i-1),255)];
    if i == m + 1
        p(i) = plot(x, Omat(i,:), 'color',c);
    else
        p(i) = plot(x, Omat(i,:), '--', 'color',[c, 1 - 1/i]);
    end
end
if mu > 1
    p(end) = plot([0, 1], repmat(1-mu^(-1), 1, 2), ':','color',[0,0,0,0.7]);
end

title(sprintf('Logistic map with \x03bc = %0.3f', mu));
xlabel('x');
ylabel('y');
if mu > 1
    legend(p([1, n + 1, m + 1, end]), {'y = x',...
       sprintf('y = f_{\x03bc}^{%i}(x)', n),...
       sprintf('y = f_{\x03bc}^{%i}(x)', m),...
       sprintf('y = 1 - \x03bc^{-1}')},...
       'location','northwest');
else
    legend(p([1, n + 1, m + 1]), {'y = x',...
       sprintf('y = f_{\x03bc}^{%i}(x)', n),...
       sprintf('y = f_{\x03bc}^{%i}(x)', m)},...
       'location','northwest');
end