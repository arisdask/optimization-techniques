% Optimization Techniques - Work 3 - mainPlotF.
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: Plot the function of the work 3.
%% Clean workplace - Initialize function
clear;
clc;
close all;

addpath('src');

syms x1 x2
f(x1,x2) = (1 / 3) * x1^2 + 3 * x2^2;

%% Task0: Plot f
% Create a meshgrid for plotting:
[X1, X2] = meshgrid(linspace(-8, 8, 100), linspace(-10, 10, 100));
% Evaluate the function over the grid:
Z = double(f(X1, X2));

% Plot 3D f(x1,x2):
figure;
subplot(1, 2, 1);
surf(X1, X2, Z);
xlabel('x1');
ylabel('x2');
zlabel('f(x1, x2)');
title('3D Plot of the Objective Function');
colormap jet;
colorbar;
shading interp;

% Convert symbolic function to MATLAB function handle
f_handler = matlabFunction(f);

Z = arrayfun(@(x1, x2) f_handler(x1, x2), X1, X2);

% 2D contour plot
subplot(1, 2, 2);
contour(X1, X2, Z, 30);
xlabel('x1');
ylabel('x2');
title('2D Contour Plot of Objective Function');
colorbar;
grid on;