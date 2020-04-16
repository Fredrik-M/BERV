
function [t, y] = euler_fwd(f, tspan, y0, h)
    n      = 1 + round((tspan(2) - tspan(1)) / h);
    t      = linspace(tspan(1), tspan(2), n)';
    h_     = t(2) - t(1);
    y      = zeros(length(t), length(y0));
    y(1,:) = y0;
    
    for i = 2:length(t)
        y(i,:) = y(i - 1,:)' + f(t(i), y(i - 1,:)) * h_;
    end
end