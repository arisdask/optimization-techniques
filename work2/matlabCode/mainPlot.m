% Optimization Techniques - Work 2 - mainPlot.
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This script solves task 1 (Plotting the function) of the work 2.
%% Task0: Clean workplace - Initialize function
clear;
clc;
close all;

addpath('src');

syms x y
f(x,y) = x^5 * exp(-x^2 - y^2);
gradF = gradient(f, [x, y]);

% % These are just criteria indicating when the method should stop running.
% epsilon = 1e-4;
% maxIter = 10000;

%% Task 1: Plot f
% Create a meshgrid for plotting:
[X, Y] = meshgrid(linspace(-3, 3, 100), linspace(-3, 3, 100));
% Evaluate the function over the grid:
Z = double(f(X, Y));

% Plot 3D f(x,y):
figure;
subplot(1, 2, 1);
surf(X, Y, Z);
xlabel('x');
ylabel('y');
zlabel('f(x, y)');
title('3D Plot of the Objective Function f(x, y) = x^5 * exp(-x^2 - y^2)');
colormap jet;
colorbar;
shading interp;

% Convert symbolic function to MATLAB function handle
f_handler = matlabFunction(f);

Z = arrayfun(@(x, y) f_handler(x, y), X, Y);

% 2D contour plot
subplot(1, 2, 2);
contourf(X, Y, Z, 50, 'LineColor', 'none');
colormap jet;
colorbar;
title('2D Contour Plot of Objective Function f(x, y) = x^5 * exp(-x^2 - y^2)');
xlabel('x');
ylabel('y');
grid on;