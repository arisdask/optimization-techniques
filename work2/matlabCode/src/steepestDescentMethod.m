% Optimization Techniques - Work 2 - steepestDescentMethod
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This is the implementation of the Steepest Descent Method.
%       This function is called inside the corresponding main script.

function [xMin, k] = steepestDescentMethod(f, gradF, x0, epsilon, maxIter, stepRule, varargin)
% Input arguments:
% - f: the objective function (symbolic)
% - gradF: the gradient of the objective function (symbolic)
% - x0: starting point (initial guess) [x_0; y_0]
% - epsilon: tolerance for stopping criterion
% - maxIter: maximum number of iterations
% - stepRule: 'constant', 'linearFmin', or 'armijo'
% - varargin: additional parameters for the step-size rule

% Output arguments:
% - xMin: the resulted minimum point
% - k: number of iterations performed

    % Convert symbolic f and gradF to MATLAB functions:
    f_handler = matlabFunction(f);
    gradF_handler = matlabFunction(gradF);
    
    x_k = x0;
    k = 0;

    xMin = zeros(500, 2);
    xMin(1, :) = x_k;
    
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

        % Determine step size gamma_k based on selected rule
        gamma_k = findGamma(f_handler, x_k, d_k, gradF_k, stepRule, varargin{:});
        
        % Update the solution
        x_k = x_k + gamma_k * d_k;
        k = k + 1;
        xMin(k + 1, :) = x_k;
    end
    
    % Return the optimized solution
    xMin = xMin(1:k+1, :);
end
