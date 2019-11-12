function [fib] = fibonacci(limit);

fib = [1 1 2];
n = 3;

while fib(1, n) <= limit - fib(1, n - 1)
    fib = [fib fib(1, n-1) + fib(1, n)];
    n = n + 1;
end

