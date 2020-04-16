% Plots the surface y = f^n(x, mu) where f^n is n:th iteration of the
% logistic map, and the plane y = x.

mu = linspace(0, 4, 21);
x  = linspace(0, 1, 101);
n  = 10;

% =======================================================================

Omat = zeros(n + 1, length(x), length(mu));
for i = 1:length(mu)
    Omat(:,:,i) = orbit(@(x)logistic(x, mu(i)), x, n);
end

mesh(x, mu, squeeze(Omat(1,:,:))',...
     'EdgeColor',[0.7,0.7,0.7],...
     'LineStyle','none',...
     'FaceAlpha',0.35);
 hold;
 mesh(x, mu, squeeze(Omat(end,:,:))',...
     'FaceColor','flat',...
     'FaceAlpha',0.75);

title(sprintf('Iteration %i of logistic map with \x03bc \x03b5 [%0.2f, %0.2f]', n, mu(1), mu(end)));
xlabel('x');
ylabel(sprintf('\x03bc'));
zlabel('y');