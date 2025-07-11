% Optimization Techniques - Work 1 - *Method 4: Dichotomous Derivative Method*
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This function is used in 'method4_dichotomousDerivative.m' file

function [ak, bk, n] = dichotomousDerivative(df, a, b, l)
% - Inputs:
% df       derivative of function
% a, b     initial interval (lower and upper bounds)
% l        stopping tolerance/accuracy criterion
%
% - Outputs:
% ak and bk  vectors which represent the values of bounds foreach iteration
% n          counts the iterations were needed to satisfy accuracy

    n = 0;
    ak = zeros(100, 1);
    bk = zeros(100, 1);
    ak(1) = a;
    bk(1) = b;

    while b - a > l
        n = n + 1;
        x_mid = (a + b) / 2;

        df_ = df(x_mid);

        if abs(df_) < 10^-20
            a = x_mid;
            b = x_mid;
            break;
        elseif df_ < 0
            a = x_mid;
        else
            b = x_mid;
        end

        ak(n + 1) = a;
        bk(n + 1) = b;
    end

    ak = ak(1:n+1);
    bk = bk(1:n+1);
end