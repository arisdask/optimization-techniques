% Optimization Techniques - Work 1 - *Method 1: Dichotomous Method*
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This function is used in 'method1_dichotomous.m' file

function [ak, bk, n] = dichotomousMethod(f, a, b, l, epsilon)
% - Inputs:
% f        function
% a, b     initial interval (lower and upper bounds)
% l        stopping tolerance/accuracy criterion
% epsilon  defines the distance from the midpoint of the interval
%
% - Outputs:
% ak and bk  vectors which represent the values of bounds foreach iteration
% n          counts the iterations were needed to satisfy accuracy

    n = 0;
    ak = zeros(100, 1);
    bk = zeros(100, 1);
    ak(1) = a;
    bk(1) = b;

    while (b - a) > l
        n = n + 1;
        x1 = (a + b) / 2 - epsilon;
        x2 = (a + b) / 2 + epsilon;

        f1 = f(x1);
        f2 = f(x2);

        % update interval
        if f1 < f2
            b = x2;
        else
            a = x1;
        end

        ak(n + 1) = a;
        bk(n + 1) = b;
    end

    ak = ak(1:n+1);
    bk = bk(1:n+1);
end