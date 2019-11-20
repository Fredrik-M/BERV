% Computes the coefficients of the linear polynomial through the points 
% (x_0, y_0) and (x_1, y_1) given by the 1 x 2 argument vectors.

function c = myLinInterpol(x, y)

c_1 = (y(2) - y(1)) / (x(2) - x(1));
c = [y(1) - x(1) * c_1 c_1];

