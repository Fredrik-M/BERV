% odeRal :: function(t, y), [y0_1, ..., y0_n], [t0, tm], h -> [T, [y1, ..., yn]]
% Solves a system of n first order differential equations using Ralstons
% method. Returns a m x n+1 matrix. 
% function(t, y)    :: t, [y1(t), ..., yn(t)] -> [y1'(t); ...; yn'(t)]
% [y0_1, ..., y0_n] :: initial conditions
% [t0, tm]          :: interval to solve over
% h                 :: step size

function [t, y] = odeRal(f, tspan, y0, h)
  n      = 1 + round((tspan(2) - tspan(1)) / h);
  t      = linspace(tspan(1), tspan(2), n)';
  h_     = t(2) - t(1)
  y      = zeros(length(t), length(y0));
  y(1,:) = y0;
  
  for i = 2:length(t)
      k1 = f(t(i-1), y(i-1,:))';
      k2 = f(t(i-1) + 2/3 * h_, y(i-1,:) + 2/3 * h_ * k1)';
      y(i,:) = y(i-1,:) + .25 * h_ * (k1 + 3 * k2);
  end
end