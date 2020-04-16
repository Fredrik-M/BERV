% Quick and dirty implementation of Newton-Raphson

function X = newtRap(f, df, x0, absTol)
    X  = x0;
    i  = 1;
    while any(abs(f(X)) > absTol)
        X = X - f(X)./df(X);
        if i > 50
            fprintf('Error: newtRap failed (%i iterations)\n', i);
            disp([x0',f(X)']);
            break;
        end
        i = i + 1;
    end
end