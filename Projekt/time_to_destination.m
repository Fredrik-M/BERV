% Return the time taken to drive though route from position(0) to
% position(x), using trapet method with n intervals.
function result = time_to_destination(x, route, n)
velocities = velocity(linspace(0, x, n+1), route);
reciprocal = 1./velocities;
result = trapet(reciprocal, 0, x);
end