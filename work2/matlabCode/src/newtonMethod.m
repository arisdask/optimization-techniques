% Optimization Techniques - Work 2 - newtonMethod
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This is the implementation of the Newton Method.
%       This function is called inside the corresponding main script.

function [xMin, k] = newtonMethod(f, gradF, x0, epsilon, maxIter, stepRule, varargin)
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

    % Convert symbolic f and gradF to MATLAB functions
    f_handler = matlabFunction(f);
    gradF_handler = matlabFunction(gradF);
    
    hessianF = hessian(f, [symvar(f)]);
    hessianF_handler = matlabFunction(hessianF);
    
    x_k = x0;
    k = 0;
    
    xMin = zeros(500, 2);
    xMin(1, :) = x_k;
    
    % Main loop for the Newton method
    while  k < maxIter + 1
        % Gradient's value at current point, xk:
        gradF_k = gradF_handler(x_k(1), x_k(2));
        
        % Stopping Criterion:
        if norm(gradF_k) < epsilon
            break;
        end
        
        % Hessian's value at current point, xk:
        hessianF_k = hessianF_handler(x_k(1), x_k(2));
        % Compute the eigenvalues of Hessian matrix:
        eigenvalues = eig(hessianF_k);

        % For the newton's method to work, the hessian matrix should be at 
        % each x_k positive-definite. If not, it is faulty to use this 
        % method for this function.
        % Check if all eigenvalues are positive (to check the previous):
        if ~ all(eigenvalues > 0)
            fprintf('> The hessian matrix for x_k = [%.2f, %.2f] is not positive-definite.\n', x_k(1), x_k(2));
            break;

            % If the statement is true, then we stop the method here.
        end

        
        % d_k = -[Hessian(x_k)]^(-1) * gradF(x_k)
        try
            d_k = -inv(hessianF_k) * gradF_k;
        catch ME
            % Just in case the Hessian matrix is non-invertible
            warning('Hessian is non-invertible at iteration %d. Stopping iteration.', k);
            break;
        end
        
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
