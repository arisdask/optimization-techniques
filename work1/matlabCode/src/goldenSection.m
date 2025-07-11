% Optimization Techniques - Work 1 - *Method 2: Golden Section*
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This function is used in 'method2_goldenSection.m' file

function [ak, bk, n] = goldenSection(f, a, b, l)
% - Inputs:
% f    function
% a    lower bound of the interval
% b    upper bound of the interval
% l    tolerance for stopping criterion (accuracy criterion)
%
% - Outputs:
% ak  vector which represent the values of *lower* bound for each iteration
% bk  vector which represent the values of *upper* bound for each iteration
% n   counts the iterations were needed to satisfy accuracy

    phi = (1 + sqrt(5)) / 2;    % golden ratio constant φ
    resphi = phi - 1;           % also referred to bibliography as γ
    
    x1 = b - resphi * (b - a);
    x2 = a + resphi * (b - a);
    f1 = f(x1);
    f2 = f(x2);
    
    ak = zeros(100, 1);
    bk = zeros(100, 1);
    ak(1) = a;
    bk(1) = b;

    n = 0;
    while (b - a) > l
        if f1 < f2
            % new interval [a, x2]
            b = x2;
            
            x2 = x1; 
            f2 = f1;
            
            x1 = b - resphi * (b - a);
            f1 = f(x1);
        else
            % new interval [x1, b]
            a = x1;
            
            x1 = x2;
            f1 = f2;
            
            x2 = a + resphi * (b - a);
            f2 = f(x2);
        end

        n = n + 1;
        ak(n + 1) = a;
        bk(n + 1) = b;
    end
    
    ak = ak(1:n+1);
    bk = bk(1:n+1);
end
