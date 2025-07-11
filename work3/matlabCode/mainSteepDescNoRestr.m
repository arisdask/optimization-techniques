% Optimization Techniques - Work 3 - Steepest Descent No Restrictions.
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This script solves task 1 (Steepest Descent) of the work 3.
%% Clean workplace - Initialize function
clear;
clc;
close all;

addpath('src');

syms x1 x2
f(x1,x2) = (1 / 3) * x1^2 + 3 * x2^2;
gradF = gradient(f, [x1, x2]);

epsilon = 0.001;
maxIter = 2000;

%% Task1: Steepest Descent Method No Restrictions
x0      = [5; -5];

gamma   = 0.1;
s       = -1;   % not used for this method.
displayMethodResults('SteepDescNoRestr', @steepestDescentMethod, ...
                f, gradF, x0, epsilon, maxIter, gamma, s);

gamma   = 0.3;
s       = -1;   % not used for this method.
displayMethodResults('SteepDescNoRestr', @steepestDescentMethod, ...
                f, gradF, x0, epsilon, maxIter, gamma, s);

gamma   = 3;
s       = -1;   % not used for this method.
displayMethodResults('SteepDescNoRestr', @steepestDescentMethod, ...
                f, gradF, x0, epsilon, maxIter, gamma, s);

gamma   = 5;
s       = -1;   % not used for this method.
displayMethodResults('SteepDescNoRestr', @steepestDescentMethod, ...
                f, gradF, x0, epsilon, maxIter, gamma, s);
