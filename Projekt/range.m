% Return how many kilometers can the car drive more, given its
% model, the route it drives at and the charge it started with using
% simpson method to approaximate the range.
function r = range(x, carmodel, route, charge, n)
total_consumption = tot_consumption(x, carmodel, route, n);
average_consumption = total_consumption/x;
remaining_charge = charge - total_consumption;
r = remaining_charge/average_consumption;
end