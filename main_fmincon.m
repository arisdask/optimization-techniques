% Optimization Techniques - Project - main_fmincon
% Author: Aristeidis Daskalopoulos (AEM: 10640)

clear; clc; close all;

% Initialize problem values
[V, a, c] = initProblemValues;

x0 = ones(17,1) * (V / 17);

% Lower and upper bounds
lb = zeros(17,1);  % No negative flow
ub = c(:) - 1e-3;  % Ensure x_i < c_i

options = optimoptions('fmincon', 'Algorithm', 'sqp', 'Display', 'iter');
[x_opt, fval] = fmincon(@(x) totalTravelTime(x, a, c), x0, [], [], [], [], lb, ub, @flowConstraints, options);

fprintf('Optimal Traffic Flow:\n');
disp(x_opt');
fprintf('Minimum Total Travel Time: %f min\n', fval);


% % % % % % % % % % %   Total travel time function   % % % % % % % % % % %
function totalTime = totalTravelTime(x, aValues, cValues)
    totalTime = 0;
    for i = 1:1:length(x)
        if x(i) >= cValues(i)
            totalTime = Inf;
            return;
        end
        totalTime = totalTime + (aValues(i) * x(i)) / (1 - (x(i) / cValues(i)));
    end
end


% % % % % % % % % % %  Flow conservation constraints  % % % % % % % % % % %
function [c, ceq] = flowConstraints(x)
    [V, ~, ~] = initProblemValues();
    
    ceq = [
        sum(x(1:4)) - V;
        x(5) + x(6) - x(1);
        x(7) + x(8) - x(2);
        x(9) + x(10) - x(4);
        x(11) + x(12) + x(13) - (x(9) + x(3) + x(8));
        x(14) + x(15) - (x(6) + x(7) + x(13));
        x(16) - (x(5) + x(14));
        x(17) - (x(10) + x(11));
        V - (x(17) + x(12) + x(15) + x(16));
    ];
    
    c = [];  % No inequality constraints
end


% % % % % % % % % % %   Initialize problem values   % % % % % % % % % % %
function [vValue, aValues, cValues] = initProblemValues
    vValue  = 100;
    % vValue  = 85;
    aValues = [1.25 1.25 1.25 1.25 1.25 1.5 1.5 1.5 1.5 1.5 1 1 1 1 1 1 1];
    cValues = [54.13 21.56 34.08 49.19 33.03 21.84 29.96 24.87 47.24 33.97 26.89 32.76 39.98 37.12 53.83 61.65 59.73];
end
