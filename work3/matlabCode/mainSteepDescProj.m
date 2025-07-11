% Optimization Techniques - Work 3 - Steepest Descent With Restrictions.
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This script solves task 2-4 of the work 3.
%% Clean workplace - Initialize function
clear;
clc;
close all;

addpath('src');

syms x1 x2
f(x1,x2) = (1 / 3) * x1^2 + 3 * x2^2;
gradF = gradient(f, [x1, x2]);

epsilon = 0.01;
maxIter = 2000;

%% Task2-4: Steepest Descent Method *With Restrictions*
% % global restrictionsList
% % Change the restrictions inside the: src/steepestDescentProjMethod.m

x0      = [5; -5];
gamma   = 0.5;
s       = 5;
displayMethodResults('SteepDescProj', @steepestDescentProjMethod, ...
                f, gradF, x0, epsilon, maxIter, gamma, s);

x0      = [-5; 10];
gamma   = 0.1;
s       = 15;
displayMethodResults('SteepDescProj', @steepestDescentProjMethod, ...
                f, gradF, x0, epsilon, maxIter, gamma, s);

x0      = [8; -10];
gamma   = 0.2;
s       = 0.1;
displayMethodResults('SteepDescProj', @steepestDescentProjMethod, ...
                f, gradF, x0, epsilon, maxIter, gamma, s);
