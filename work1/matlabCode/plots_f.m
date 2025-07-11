% Optimization Techniques - Work 1 - *Functions Plots*
% Author: Aristeidis Daskalopoulos (AEM: 10640)

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

t = linspace(a, b, 300);

figure('Name', 'Plots');
subplot(1, 3, 1);
plot(t, f1(t), 'LineStyle', '-', 'LineWidth', 2.5);
ylabel('f_1(x)', 'FontSize', 15);
xlabel('x', 'FontSize', 15);
title('f1 Plot', 'FontSize', 17);

subplot(1, 3, 2);
plot(t, f2(t), 'LineStyle', '-', 'LineWidth', 2.5);
ylabel('f_2(x)', 'FontSize', 15);
xlabel('x', 'FontSize', 15);
title('f2 Plot', 'FontSize', 17);

subplot(1, 3, 3);
plot(t, f3(t), 'LineStyle', '-', 'LineWidth', 2.5);
ylabel('f_3(x)', 'FontSize', 15);
xlabel('x', 'FontSize', 15);
title('f3 Plot', 'FontSize', 17);