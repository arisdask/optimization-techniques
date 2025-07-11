% Optimization Techniques - Work 3 - steepestDescentProjMethod
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This is the implementation of the Steepest Descent Method With Restrictions.
%       This function is called inside the corresponding main script.

function [xMin, k] = steepestDescentProjMethod(f, gradF, x0, epsilon, maxIter, gamma, s)
% Input arguments:
% - f:          the objective function (symbolic)
% - gradF:      the gradient of the objective function (symbolic)
% - x0:         starting point (initial guess) [x_0; y_0]
% - epsilon:    tolerance for stopping criterion
% - maxIter:    maximum number of iterations
% - gamma:      value of gamma_k
% - s:          value of s_k

% Output arguments:
% - xMin:   the resulted minimum point
% - k:      number of iterations performed

    restrictionsList = [-10, 5; -8, 12];

    % Convert symbolic f and gradF to MATLAB functions:
    f_handler       = matlabFunction(f);
    gradF_handler   = matlabFunction(gradF);
    
    x_k = x0;
    k   = 0;

    xMin        = zeros(1000, 2);
    xMin(1, :)  = x_k;
    
    % Main loop for the steepest descent method
    while k < maxIter + 1
        % Gradient's value at current point, xk:
        gradF_k = gradF_handler(x_k(1), x_k(2));
        
        % Check stopping criterion
        if norm(gradF_k) < epsilon
            break;
        end
        
        % Compute the descent direction
        d_k = -gradF_k;

        xBar = x_k + s * d_k;
        xBar = ProjFunc(xBar, restrictionsList);
        
        % Update the solution
        x_k             = x_k + gamma * (xBar - x_k);
        k               = k + 1;
        xMin(k + 1, :)  = x_k;
    end
    
    % Return the optimized solution
    xMin = xMin(1:k+1, :);
end
