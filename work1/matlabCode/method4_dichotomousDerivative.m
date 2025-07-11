% Optimization Techniques - Work 1 - *Method 4: Dichotomous Derivative Method*
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This script only has the solution of Problem 4

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

df1 = diff(f1, x);
df2 = diff(f2, x);
df3 = diff(f3, x);


%% 1: 
% We change the 'l' value to check how the total iterations 
% 'n' of the method changes.

% The number of points we take to make the diagram:
sampleSize = 30;

lList = linspace(0.01, 0.1, sampleSize);
iterationsList = zeros(sampleSize, 3); % Store total iterations per l

for i = 1:1:sampleSize
    l = lList(i);
    [~, ~, n1] = dichotomousDerivative(matlabFunction(df1), a, b, l);
    [~, ~, n2] = dichotomousDerivative(matlabFunction(df2), a, b, l);
    [~, ~, n3] = dichotomousDerivative(matlabFunction(df3), a, b, l);

    iterationsList(i, 1) = n1;
    iterationsList(i, 2) = n2;
    iterationsList(i, 3) = n3;
end

figure('Name', 'Dichotomous Derivative Method');
plot(lList, iterationsList(:, 1), 'LineStyle', '-', 'LineWidth', 3);
hold on
plot(lList, iterationsList(:, 2), 'LineStyle', '--', 'LineWidth', 2);
hold on
plot(lList, iterationsList(:, 3), 'LineStyle', ':', 'LineWidth', 1.5);
ylabel('Total f_i(x) calculations n', 'FontSize', 15);
xlabel('Tolerance l', 'FontSize', 15);
title('n - l diagram', 'FontSize', 17);
legu1 = legend('f1', 'f2', 'f3');
set(legu1, 'FontSize', 12);


%% 2:
lValues = [0.003, 0.006, 0.01, 0.1];
colorArray = [1 0 0; 0 1 0; 0 0 1; 0 0 0];
dfuncArray = {df1, df2, df3};

for p = 1:1:length(dfuncArray)
    figure('Name', ['Dichotomous Derivative Method Bounds in f', num2str(p), '(x)']);

    for i = 1:1:length(lValues)
        l = lValues(i);
        [ak, bk, n] = dichotomousDerivative(dfuncArray{p}, a, b, l);
        plot(0:1:length(ak)-1, ak, 'LineStyle', '-', 'LineWidth', 2.5, 'Color', colorArray(i, :));
        hold on
        h1 = plot(0:1:length(bk)-1, bk, 'LineStyle', '-', 'LineWidth', 2.5, 'Color', colorArray(i, :));
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
funcArray = {f1, f2, f3};

for p = 1:1:length(dfuncArray)
    [ak, bk, n] = dichotomousDerivative(dfuncArray{p}, a, b, l);
    xMin = ( ak(end) + bk(end) ) / 2;
    fMin = funcArray{p}(xMin);

    [xMin_, fMin_] = fminbnd(matlabFunction(funcArray{p}), a, b);

    fprintf(['%d)Function f%d(x) in interval [%.2f, %.2f] ' ...
        'according to the method has x* =  %f' ...
        ' and fp(x*) = %f \nThe actual x* is  %f and fp(x*) = %f \n\n' ...
        ], p, p, a, b, xMin, fMin, xMin_, fMin_);
end

disp('- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ');