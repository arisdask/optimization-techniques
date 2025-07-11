% Optimization Techniques - Work 2 - Main script of Levenberg Marquardt.
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This script solves task 4 (Levenberg Marquardt) of the work 2.
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

%% Task4: Levenberg Marquardt Method
x0_list = [-1, 0, +1;
           +1, 0, -1];

fprintf(' --> Starting Task4: Levenberg Marquardt\n');
% For each initial point x0 we will run the same algorithm:
for i = 1:1:size(x0_list, 2)
    x0 = x0_list(:, i);
    fprintf(' - - -  For x_0 = %0.2f, y_0 = %0.2f  - - - \n', x0(1), x0(2));
    
    stepRule = 'constant';
    gamma = 0.5;
    figure('Name', sprintf('Levenberg Marquardt Running for: x_0 = %0.2f, y_0 = %0.2f', x0(1), x0(2)));
    % Call the method with the constant gamma rule:
    displayMethodResults('Levenberg Marquardt', @levenbergMarquardtMethod, ...
                    f, gradF, x0, epsilon, maxIter, stepRule, gamma);
    
    stepRule = 'linearFmin';
    % Call the method with the linearFmin rule for gamma:
    displayMethodResults('Levenberg Marquardt', @levenbergMarquardtMethod, ...
                    f, gradF, x0, epsilon, maxIter, stepRule);

    stepRule = 'armijo';
    alfa = 0.01;
    beta = 0.25;
    s = 5.0;
    % Call the method with the Armijo rule:
    displayMethodResults('Levenberg Marquardt', @levenbergMarquardtMethod, ...
                    f, gradF, x0, epsilon, maxIter, stepRule, alfa, beta, s);
    fprintf(' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n\n');
end
fprintf(' --> End Task4: Levenberg Marquardt\n\n');
