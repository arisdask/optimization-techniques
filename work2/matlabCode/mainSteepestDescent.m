% Optimization Techniques - Work 2 - mainSteepestDescent.
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This script solves task 2 (Steepest Descent) of the work 2.
%% Task0: Clean workplace - Initialize function
clear;
clc;
close all;

addpath('src');

syms x y
f(x,y) = x^5 * exp(-x^2 - y^2);
gradF = gradient(f, [x, y]);

% These are just criteria indicating when the method should stop running.
epsilon = 1e-4;
maxIter = 10000;

%% Task2: Steepest Descent Method
x0_list = [-1, 0, +1;
           +1, 0, -1];

fprintf(' --> Starting Task2: Steepest Descent Method\n');
% For each initial point x0 we will run the same algorithm:
for i = 1:1:size(x0_list, 2)
    x0 = x0_list(:, i);
    fprintf(' - - -  For x_0 = %0.2f, y_0 = %0.2f  - - - \n', x0(1), x0(2));
    
    stepRule = 'constant';
    gamma = 0.5;
    figure('Name', sprintf('Steepest Descent Running for: x_0 = %0.2f, y_0 = %0.2f', x0(1), x0(2)));
    % Call the steepest descent method with the constant gamma rule:
    displayMethodResults('Steepest Descent', @steepestDescentMethod, ...
                    f, gradF, x0, epsilon, maxIter, stepRule, gamma);
    
    stepRule = 'linearFmin';
    % Call the steepest descent method with the linearFmin rule for gamma:
    displayMethodResults('Steepest Descent', @steepestDescentMethod, ...
                    f, gradF, x0, epsilon, maxIter, stepRule);
    
    stepRule = 'armijo';
    alfa = 0.01;
    beta = 0.25;
    s = 5.0;
    % Call the steepest descent method with the Armijo rule:
    displayMethodResults('Steepest Descent', @steepestDescentMethod, ...
                    f, gradF, x0, epsilon, maxIter, stepRule, alfa, beta, s);
    fprintf(' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n\n');
end
fprintf(' --> End Task2: Steepest Descent Method\n\n');
