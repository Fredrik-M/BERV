% Computes the total energy consumption in Wh for the given car model and
% distance x along the given route, using Simpsons method of integration
% with n intervals. If n is odd, n + 1 is used instead.

function E = tot_consumption(x, model, route, n)

if mod(n, 2)
    n = n + 1;
end

s = velocity(linspace(0, x, n + 1), route);
c = consumption(s, model);

E = simpson(0, x, c);