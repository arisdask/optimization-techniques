% Optimization Techniques - Work 2 - Display Method's Results.
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info:
% This function provides an abstraction layer in which, given the method 
% (and the rule for gamma) it runs the method and solves all the 
% corresponding questions (making the necessary plots). 

function displayMethodResults(methodName, methodHandle, f, gradF, x0, epsilon, maxIter, stepRule, varargin)
% Displays Method's results.
%
% Input arguments:
% - methodName: string, name of the optimization method
% - methodHandle: function handle to the method
% - f: symbolic function representing the objective function
% - gradF: symbolic gradient of the objective function
% - x0: initial point [x_0; y_0]
% - epsilon: tolerance for stopping criterion
% - maxIter: maximum number of iterations (to avoid infinite loops)
% - stepRule: string, declares the type of step-size γ_k rule ('constant', 'linearFmin', 'armijo')
% - varargin: additional parameters (different for each method and rules)

    % Run the optimization method
    [xMin_k, k] = methodHandle(f, gradF, x0, epsilon, maxIter, stepRule, varargin{:});
    
    i = 0; % This is a helper variable a more compact plotting.
    % Display method parameters and results
    fprintf('Method: %s  -  ', methodName);
    fprintf('Step-Size Rule: %s ', stepRule);
    switch stepRule
        case 'constant'
            i = 1;
            % Only one extra argument means we use the constant rule
            fprintf('(gamma = %.4f)\n', varargin{1});
        case 'linearFmin'
            i = 2;
            % No extra arguments means we use the linearFmin.
            fprintf('\n');
        case 'armijo'
            i = 3;
            fprintf('(alfa = %.4f, beta = %.4f, s = %.4f)\n', varargin{1}, varargin{2}, varargin{3});
    end
    fprintf("Initial Point: [%f, %f]'  -  ", x0(1), x0(2));
    fprintf('Tolerance (epsilon): %e\n', epsilon);
    if k >= maxIter + 1
        fprintf("Method run for more than %d iterations and stopped. " + ...
            "The results may not converge to the real ones.\n", maxIter);
    end

    fprintf('Resulted Minimum Point: [%f, %f]\n', xMin_k(k+1, 1), xMin_k(k+1, 2));
    fprintf('Minimum Function Value: %f\n', f(xMin_k(k+1, 1), xMin_k(k+1, 2)));
    fprintf('Number of Iterations: %d\n', k);
    
    % Plot (x, y) over the number of iterations k,
    % x_i = xMin_k(i, 1) and y_i = xMin_k(i, 2):

    % figure;
    [X, Y] = meshgrid(linspace(-3, 3, 200), linspace(-3, 3, 200));
    f_handler = matlabFunction(f);
    Z = f_handler(X, Y);
    
    subplot(2, 3, i);
    hold on;
    
    % Plot filled contours
    contourf(X, Y, Z, 50, 'LineColor', 'none');
    colormap jet;
    colorbar;
    clim([min(Z(:)), max(Z(:))]);
    
    scatter(xMin_k(:, 1), xMin_k(:, 2), 50, 'MarkerFaceColor', 'cyan', 'MarkerEdgeColor', 'black'); 
    plot(xMin_k(:, 1), xMin_k(:, 2), '-o', 'Color', [0, 0, 0], 'LineWidth', 1.5, 'MarkerSize', 3, 'MarkerFaceColor', 'yellow');
    xlabel('x', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('y', 'FontSize', 12, 'FontWeight', 'bold');
    title(sprintf('x0 = (%.2f,%.2f) | (%s - %s)', xMin_k(1, 1), xMin_k(1, 2), methodName, stepRule));
    grid on;
    set(gca, 'LooseInset', get(gca, 'TightInset'));
    hold off;

    % Plot f(x_k, y_k):
    subplot(2, 3, i + 3);
    plot(1:(k+1), f(xMin_k(:, 1), xMin_k(:, 2)), '-', 'LineWidth', 2);
    title(sprintf('f(x_k,y_k) over iterations (%s - %s)', methodName, stepRule));
    xlabel('Iteration (k)');
    ylabel('f(x_k,y_k)-Values');
    grid on;
end
