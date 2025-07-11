% Optimization Techniques - Work 2 - Levenberg Marquardt Method
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This is the implementation of theLevenberg Marquardt Method.
%       This function is called inside the corresponding main script.

function [xMin, k] = levenbergMarquardtMethod(f, gradF, x0, epsilon, maxIter, stepRule, varargin)
% Input arguments:
% - f: the objective function (symbolic)
% - gradF: the gradient of the objective function (symbolic)
% - x0: starting point (initial guess) [x_0; y_0]
% - epsilon: tolerance for stopping criterion
% - maxIter: maximum number of iterations
% - stepType: step-size determination method ('armijo')
% - varargin: additional parameters like initial damping factor μ_0

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
    
    I = eye(length(x0));
    
    % Main loop for the Levenberg-Marquardt method
    while k < maxIter + 1
        % Gradient's value at current point, xk:
        gradF_k = gradF_handler(x_k(1), x_k(2));
        
        % Stopping Criterion:
        if norm(gradF_k) < epsilon
            break;
        end
        
        % Hessian's value at current point, xk:
        hessianF_k = hessianF_handler(x_k(1), x_k(2));
        
        % Adjust μ_k to make the modified Hessian become positive-definite:
        % mu_k = abs( min(eigenvalues) );
        mu_k = 0;
        modifiedHessian = hessianF_k + mu_k * I;
        % Compute the eigenvalues of modified Hessian matrix:
        eigenvalues = eig(modifiedHessian);
        while ~ all(eigenvalues > 0)
            mu_k = mu_k + 1;
            modifiedHessian = hessianF_k + mu_k * I;
            eigenvalues = eig(modifiedHessian);
        end
        
        
        % Solve the system: (Hessian + μ_k * I) * d_k = -gradF
        d_k = -modifiedHessian \ gradF_k;
        
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
