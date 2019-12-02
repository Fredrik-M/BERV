function r = range(x, carmodel, route, charge, n)
% Return how may kilometers can the car drive more, given its model, the
% route, the charge it started at, and the distance it has already passed.
total_consumption = tot_consumption(x, carmodel, route, n);
average_consumption = total_consumption/x;
remaining_charge = charge - total_consumption;
r = remaining_charge/average_consumption;
end