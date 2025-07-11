% Optimization Techniques - Work 1 - *Method 3: Fibonacci Method*
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This function is used in 'method3_fibonacciMethod.m' file

function [ak, bk, n] = fibonacciMethod(f, a, b, l)
% - Inputs:
% f    function
% a    lower bound of the interval
% b    upper bound of the interval
% l    tolerance for stopping criterion
%
% - Outputs:
% ak  vector which represent the values of *lower* bound for each iteration
% bk  vector which represent the values of *upper* bound for each iteration
% n   counts the iterations were needed to satisfy accuracy

    % In Fibonacci method the tolerance l strictly predefines the number
    % of repetitions N needs to be done: (b - a) / l < F_N
    Fn = (b - a) / l;

    tmp = 30;
    fib = fibonacci(1:1:tmp);
    N = find(fib > Fn, 1);

    while isempty(N)
        tmp = tmp + 5;
        fib = fibonacci(1:1:tmp);
        N = find(fib > Fn, 1);
    end

    fib = fib(1:1:N);

    x1 = a + (fib(N - 2) / fib(N)) * (b - a);
    x2 = a + (fib(N - 1) / fib(N)) * (b - a);
    f1 = f(x1);
    f2 = f(x2);

    ak = zeros(N - 1, 1);
    bk = zeros(N - 1, 1);
    ak(1) = a;
    bk(1) = b;
    
    % n = N - 1;
    % We have N-2 and not N-1 because matlab is one-indexed but 
    % theoretically we assume that the first Fibonacci number is indexed 
    % at zero (fib(0)). So from k = 1..N-2 we can see in the calculations 
    % that we use both fib(1) when k = N-2 in fib(N - k - 1) 
    % and fib(N) when k = 1 in fib(N - k + 1)
    for k = 1:1:N-2
        if f1 < f2
            % new interval [a, x2]
            b = x2;

            x2 = x1;
            f2 = f1;

            x1 = a + (fib(N - k - 1) / fib(N - k + 1)) * (b - a);
            f1 = f(x1);
        else
            % new interval [x1, b]
            a = x1;

            x1 = x2;
            f1 = f2;

            x2 = a + (fib(N - k) / fib(N - k + 1)) * (b - a);
            f2 = f(x2);
        end

        ak(k + 1) = a;
        bk(k + 1) = b;
    end

    n = N - 2;
    % Note: In the algorithms, we were introduced 'n' as the counter of 
    % iterations need to satisfy accuracy, so for consistency with the 
    % other methods we will return N-2 and not N-1, and we will handle 
    % the output accordingly.
end
