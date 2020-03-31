% VdP_ODE :: t, [y1(t), y2(t)], L -> [y1'(t); y2'(t)]
% Returns the derivatives at t for the Van der Pol oscillator expressed as
% a system of two first order diff. equations in y1 and y2, where y1 = x, 
% y2 = x' and y1' + y2' = x'' - L(1 - x^2)x' + x = 0.

function ddt = VdP_ODE(t, y, L)
  ddt = [y(2), L * (1 - y(1)^2) * y(2) - y(1)]';
end
  
    