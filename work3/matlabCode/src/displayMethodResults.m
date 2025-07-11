% Optimization Techniques - Work 3 - Display Method's Results.
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info:
% This function provides an abstraction layer in which, given the method 
% it runs the method and makes the necessary plots (and prints).

function displayMethodResults(methodName, methodHandle, f, gradF, x0, epsilon, maxIter, gamma, s)
% Displays Method's results.
%
% Input arguments:
% - methodName:     string, name of the optimization method
% - methodHandle:   function handle to the method
% - f:              symbolic function representing the objective function
% - gradF:          symbolic gradient of the objective function
% - x0:             initial point [x_0; y_0]
% - epsilon:        tolerance for stopping criterion
% - maxIter:        maximum number of iterations (to avoid infinite loops)
% - gamma:          value of gamma_k
% - s:              value of s_k

    % Run the optimization method
    [xMin_k, k] = methodHandle(f, gradF, x0, epsilon, maxIter, gamma, s);

    % Display method parameters and results
    fprintf('gamma = %.2f - s = %.2f - ', gamma, s);
    fprintf("Initial Point: [%.2f, %.2f]'  -  ", x0(1), x0(2));
    fprintf('Tolerance (epsilon): %e\n', epsilon);
    if k >= maxIter + 1
        fprintf(">>> Method run for more than %d iterations and stopped. " + ...
            "The results may not converge to the real ones!\n", maxIter);
    end

    fprintf( 'Resulted Minimum Point: [%f, %f]\n', xMin_k(k+1, 1), xMin_k(k+1, 2) );
    fprintf( 'Minimum Function Value: %f\n', f(xMin_k(k+1, 1), xMin_k(k+1, 2)) );
    fprintf( 'Number of Iterations: %d\n', k );
    fprintf( '--------------------------------------------------------------------\n' );

    figure('Name', sprintf('Running for: x_0 = (%0.2f, %0.2f)', x0(1), x0(2)));
    [X1, X2] = meshgrid(linspace(-8, 8, 100), linspace(-10, 10, 100));
    f_handler = matlabFunction(f);
    Z = f_handler(X1, X2);
    
    subplot(1, 3, 1);
    hold on;
    
    % Plot filled contours
    contour(X1, X2, Z, 30);
    colorbar;
    hold on;
    
    scatter(xMin_k(:, 1), xMin_k(:, 2), 20, 'MarkerFaceColor', 'cyan', 'MarkerEdgeColor', 'black'); 
    plot(xMin_k(:, 1), xMin_k(:, 2), '-o', 'Color', [0, 0, 0], 'LineWidth', 1, 'MarkerSize', 2, 'MarkerFaceColor', 'yellow');
    xlabel('x1', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('x2', 'FontSize', 12, 'FontWeight', 'bold');
    title(sprintf('x0 = (%.2f,%.2f) | (gamma=%.2f - s=%.2f)', xMin_k(1, 1), xMin_k(1, 2), gamma, s));
    if strcmp(methodName, 'SteepDescNoRestr')
        title(sprintf('x0 = (%.2f,%.2f) | (gamma=%.2f)', xMin_k(1, 1), xMin_k(1, 2), gamma));
    end
    grid on;
    hold off;

    % Plot f(x1_k, x2_k):
    subplot(1, 3, 3);
    plot(1:(k+1), f(xMin_k(:, 1), xMin_k(:, 2)), '-o', 'LineWidth', 2);
    title( sprintf('f(x1_k,x2_k) over iterations - %s', methodName) );
    xlabel('Iteration (k)');
    ylabel('f(x_k,y_k)-Values');
    grid on;

    subplot(1, 3, 2);
    plot(1:(k+1), xMin_k(:, 1), 1:(k+1) ,xMin_k(:, 2), 'LineWidth', 1.5);
    legend('x1', 'x2');
    xlabel('Iteration (k)');
    grid on;
end
