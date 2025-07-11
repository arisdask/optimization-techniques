% Optimization Techniques - Work 1 - *Method 1: Dichotomous Method*
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This script only has the solution of Problem 1 (Dichotomous Method)

clear;
clc;
close all;

addpath('src');

% [a, b]: the initial interval in which we look for the minimum
a = -1;
b = 3;

% The test case functions:
syms x
f1(x) = (x - 2)^2 + x * log(x + 3);
f2(x) = exp(-2*x) + (x - 2)^2;
f3(x) = exp(x) * (x^3 - 1) + (x - 1) * sin(x);


%% 1: 
% Keeping 'l' constant, we change the 'epsilon' value to check how the 
% total iterations 'n' of the method changes.

% l: the tolerance of the final interval [a_k,b_k] (b_k - a_k < l)
l = 0.01;

% The number of points we take to make the diagram:
sampleSize = 30;

epsilonList = linspace(l/100, l/2.01, sampleSize);
iterationsList = zeros(sampleSize, 3); % Store total iterations per espilon

for i = 1:1:sampleSize
    epsilon = epsilonList(i);
    [~, ~, n1] = dichotomousMethod(f1, a, b, l, epsilon);
    [~, ~, n2] = dichotomousMethod(f2, a, b, l, epsilon);
    [~, ~, n3] = dichotomousMethod(f3, a, b, l, epsilon);

    iterationsList(i, 1) = n1;
    iterationsList(i, 2) = n2;
    iterationsList(i, 3) = n3;
end

figure('Name', 'Dichotomous Method');
subplot(1, 2, 1);
plot(epsilonList, 2 * iterationsList(:, 1), 'LineStyle', '-', 'LineWidth', 3);
hold on
plot(epsilonList, 2 * iterationsList(:, 2), 'LineStyle', '--', 'LineWidth', 2);
hold on
plot(epsilonList, 2 * iterationsList(:, 3), 'LineStyle', ':', 'LineWidth', 1.5);
ylabel('Total f_i(x) calculations: 2*n', 'FontSize', 15);
xlabel('epsilon ε', 'FontSize', 15);
title('2n - ε diagram', 'FontSize', 17);
legu1 = legend('f1', 'f2', 'f3');
set(legu1, 'FontSize', 12);


%% 2: 
% Keeping 'epsilon' constant, we change the 'l' value to check how the 
% total iterations 'n' of the method changes.
epsilon = 0.001;

% The number of points we take to make the diagram:
sampleSize = 30;

lList = linspace(epsilon * 2.01, epsilon * 100, sampleSize);
iterationsList = zeros(sampleSize, 3); % Store total iterations per l

for i = 1:1:sampleSize
    l = lList(i);
    [~, ~, n1] = dichotomousMethod(f1, a, b, l, epsilon);
    [~, ~, n2] = dichotomousMethod(f2, a, b, l, epsilon);
    [~, ~, n3] = dichotomousMethod(f3, a, b, l, epsilon);

    iterationsList(i, 1) = n1;
    iterationsList(i, 2) = n2;
    iterationsList(i, 3) = n3;
end

subplot(1, 2, 2);
plot(lList, 2 * iterationsList(:, 1), 'LineStyle', '-', 'LineWidth', 3);
hold on
plot(lList, 2 * iterationsList(:, 2), 'LineStyle', '--', 'LineWidth', 2);
hold on
plot(lList, 2 * iterationsList(:, 3), 'LineStyle', ':', 'LineWidth', 1.5);
ylabel('Total f_i(x) calculations 2*n', 'FontSize', 15);
xlabel('Tolerance l', 'FontSize', 15);
title('2n - l diagram', 'FontSize', 17);
legu1 = legend('f1', 'f2', 'f3');
set(legu1, 'FontSize', 12);


%% 3:
epsilon = 0.001;
lValues = [0.003, 0.006, 0.01, 0.1];
colorArray = [1 0 0; 0 1 0; 0 0 1; 0 0 0];
funcArray = {f1, f2, f3};

for p = 1:1:length(funcArray)
    figure('Name', ['Dichotomous Method Bounds in f', num2str(p), '(x)']);

    for i = 1:1:length(lValues)
        l = lValues(i);
        [ak, bk, n] = dichotomousMethod(funcArray{p}, a, b, l, epsilon);
        plot(0:1:n, ak, 'LineStyle', '-', 'LineWidth', 2.5, 'Color', colorArray(i, :));
        hold on
        h1 = plot(0:1:n, bk, 'LineStyle', '-', 'LineWidth', 2.5, 'Color', colorArray(i, :));
        % Sets the second plot's legend visibility to off since both plots 
        % share the same legend
        set(h1, 'HandleVisibility', 'off');
    end

    ylabel('ak-lower and bk-upper bounds', 'FontSize', 15);
    xlabel('Iteration k', 'FontSize', 15);
    title(['ak/bk - k diagram for f', num2str(p), '(x)'], 'FontSize', 17);
    legu1 = legend('l = ' + string(lValues(1)),'l = ' + string(lValues(2)), ...
        'l = ' + string(lValues(3)), 'l = ' + string(lValues(4)));
    set(legu1, 'FontSize', 12);

end



%% Extra:
% Estimate x* and f(x*) for each function in funcArray
% and check how close are these to the real values
l = 0.001;
epsilon = 0.0004;

for p = 1:1:length(funcArray)
    [ak, bk, n] = dichotomousMethod(funcArray{p}, a, b, l, epsilon);
    xMin = ( ak(end) + bk(end) ) / 2;
    fMin = funcArray{p}(xMin);

    [xMin_, fMin_] = fminbnd(matlabFunction(funcArray{p}), a, b);

    fprintf(['%d)Function f%d(x) in interval [%.2f, %.2f] ' ...
        'according to the method has x* =  %f' ...
        ' and fp(x*) = %f \nThe actual x* is  %f and fp(x*) = %f \n\n' ...
        ], p, p, a, b, xMin, fMin, xMin_, fMin_);
end

disp('- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ');