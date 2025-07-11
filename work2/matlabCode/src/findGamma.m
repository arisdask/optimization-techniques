% Optimization Techniques - Work 2 - findGamma
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: 
% This is the implementation which is used to calculate the gamma value 
% based on the rule we follow. 

function gamma_k = findGamma(f_handler, x_k, d_k, gradF_k, stepRule, varargin)
% Input arguments:
% - f_handler: function handle for the objective function
% - x_k: current point [x_k; y_k]
% - d_k: descent direction at x_k
% - gradF_k: gradient's value at xk
% - stepRule: 'constant', 'linearFmin', or 'armijo'
% - varargin: additional parameters for each step-type method

% Output arguments:
% - gamma_k: the step size for the current iteration

    switch stepRule
        case 'constant'
            % Fixed step size provided as an additional parameter:
            gamma_k = varargin{1};

        case 'linearFmin'
            % Line search to find optimal gamma_k.
            % Its the value γ_k that minimizes the f(x_k + γ_k * d_k):
            [ak, bk, n] = fibonacciMethod(@(gamma) f_handler(x_k(1) + gamma * d_k(1), x_k(2) + gamma * d_k(2)), ...
                0, 10, 1e-4);
            gamma_k = ( ak(n + 1) + bk(n + 1) ) / 2;

        case 'armijo'
            % Parameters for Armijo rule:
            if length(varargin) == 3
                alpha = varargin{1}; % α in [10^-5, 10^-1]
                beta = varargin{2};  % β in [1/10, 1/2]
                s = varargin{3};
            else 
                disp('Error: Not enough arguments for armigo rule. Usage: alpha, beta, s');
            end

            m = 0;
            gamma_k = s; % Start with the initial step size

            f_k = f_handler(x_k(1), x_k(2));

            % Armijo condition loop: find the smallest m that satisfies the condition
            while f_handler(x_k(1) + gamma_k * d_k(1), x_k(2) + gamma_k * d_k(2)) > ...
                    (f_k + alpha * (beta^m) * s * (d_k' * gradF_k))
                m = m + 1;
                % Update step size based on γ_k = s*(β^m_k):
                gamma_k = s * (beta^m);
            end
    end
end
