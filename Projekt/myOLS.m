function c = myOLS(x, y)

M = [1./x' ones(length(x), 1) x' x.^2'];
c = (M' * M)\(M' * y');