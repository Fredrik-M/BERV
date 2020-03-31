% Computes coefficients for the least squares approximation to the data
% points (x, y) given by the argument vectors x and y, on the form
% c_0 * x^-1 + c_1 + c_2 * x + c_3 * x^2.

function c = myOLS(x, y)

M = [1./x' ones(length(x), 1) x' x.^2'];
c = (M' * M)\(M' * y');