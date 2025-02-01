% Optimization Techniques - Project - mainGridV
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: ...

%% Clean workplace - Initialize Problem
clear; clc; close all;
addpath('src'); addpath('utils'); addpath('lib');

% Parameter Initialization
V_values = linspace(85, 115, 50);  % Vector of V values
[~, a, c, populationSize, numOfSelections] = initializeProblemValues;
chromosomeSize = 17;  % From x1 to x17

alpha = 0.05;  % Parameter: controls sensitivity of fitness function over T

% Exponential fitness function: higher fitness for lower T
fitnessScoreFunc = @(totalTime) exp(-alpha * (totalTime));

% Inverse fitness function: recovers totalTime from fitness
inverseFitnessScoreFunc = @(fitnessScore) - log(fitnessScore)/alpha;

% Parameters
maxGenerations = 5000;   % Maximum number of generations
tolerance      = 1e-1;   % Stopping criterion tolerance
n              = 200;    % Stability Window: Number of generations to check for convergence stability
printLogs      = false;  % Disable logging for multiple runs

bestTimeOverall       = Inf;
bestChromosomeOverall = [];
bestVOverall          = NaN;

totalTimes = zeros(length(V_values), 1);

%% Loop through V values
for j = 1:1:length(V_values)
    V = V_values(j);
    fprintf('\nRunning GA optimization for V = %d\n', V);

    % Initialize Population
    population = initializePopulationConstV(populationSize, chromosomeSize, c, V);
    for i = 1:1:populationSize
        if ~validateChromosome(population(i, :), c, V)
            error('initializePopulation: Invalid Initial Chromosome for V = %d', V);
        end
    end

    % Run Evolution Loop
    [population, bestFitness, bestSolution, generation, bestFitnessScores, meanFitnessScores] = ...
        runEvolutionLoop(population, a, c, V, fitnessScoreFunc, inverseFitnessScoreFunc, ...
                         numOfSelections, maxGenerations, tolerance, n, printLogs);

    % Compute the best total time for this V
    bestTime = inverseFitnessScoreFunc(bestFitness);
    totalTimes(j) = bestTime;

    fprintf('Best total time for V = %d: %f\n', V, bestTime);

    % We check if this is the best overall solution so far
    if bestTime < bestTimeOverall
        bestTimeOverall       = bestTime;
        bestChromosomeOverall = bestSolution;
        bestVOverall          = V;
    end
end

%% Plot V vs Total Time
figure;
plot(V_values, totalTimes, '-o', 'LineWidth', 2);
xlabel('V Value');
ylabel('Total Time');
title('Total Time - V Value');
grid on;

%% Final Outputs
fprintf('\nBest *overall* solution found for V = %d\n', bestVOverall);
fprintf('Best Total Time: %f\n', bestTimeOverall);
fprintf('Best Chromosome:\n');
disp(bestChromosomeOverall);

if validateChromosome(bestChromosomeOverall, c, bestVOverall)
    fprintf('Resulted Chromosome Valid !!\n');
else
    fprintf('Resulted Chromosome Invalid :(\n');
end
