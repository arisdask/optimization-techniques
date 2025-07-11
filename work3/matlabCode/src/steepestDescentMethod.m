% Optimization Techniques - Work 3 - steepestDescentMethod (No Restrictions)
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This is the implementation of the Steepest Descent Method.
%       This function is called inside the corresponding main script.

function [xMin, k] = steepestDescentMethod(f, gradF, x0, epsilon, maxIter, gamma, s)
% Input arguments:
% - f:          the objective function (symbolic)
% - gradF:      the gradient of the objective function (symbolic)
% - x0:         starting point (initial guess) [x_0; y_0]
% - epsilon:    tolerance for stopping criterion
% - maxIter:    maximum number of iterations
% - gamma:      value of gamma_k
% - s:          value of s_k (no need for this function)

% Output arguments:
% - xMin: the resulted minimum point
% - k: number of iterations performed

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
        
        % Update the solution
        x_k             = x_k + gamma * d_k;
        k               = k + 1;
        xMin(k + 1, :)  = x_k;
    end
    
    % Return the optimized solution
    xMin = xMin(1:k+1, :);
end
