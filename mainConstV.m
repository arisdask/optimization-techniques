% Optimization Techniques - Project - mainConstV
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: ...

%% Clean workplace - Initialize Problem
clear; clc; close all;
addpath('src'); addpath('utils'); addpath('lib');

[V, a, c, populationSize, numOfSelections] = initializeProblemValues;
chromosomeSize = 17;  % From x1 to x17, for const V

alpha = 0.05;  % Parameter: controls sensitivity of fitness function over T

% Fitness function: higher fitness for lower T
% Inverse fitness function: recovers totalTime from fitness

% fitnessScoreFunc        = @(totalTime) exp(-alpha * (totalTime));
% inverseFitnessScoreFunc = @(fitnessScore) - log(fitnessScore)/alpha;

fitnessScoreFunc        = @(totalTime) 1 / (totalTime - 700)^6;
inverseFitnessScoreFunc = @(fitnessScore) 1 / fitnessScore^(1/6) + 700;

%% Initialize Population
% Parameters
maxGenerations = 1200;  % Maximum number of generations
tolerance      = 1e-1;  % Stopping criterion tolerance
n              = 20;   % Stability Window: Number of generations to check for convergence stability
printLogs      = true;  % Enable debug logging output to console

% Initialize Population
population = initializePopulationConstV(populationSize, chromosomeSize, c, V);
for i = 1:1:populationSize
    if ~validateChromosome(population(i, :), c, V)
        error('initializePopulation: Invalid Initial Chromosome');
    end
end

%% Run Evolution Loop
[population, bestFitness, bestSolution, generation, bestFitnessScores, meanFitnessScores] = ...
    runEvolutionLoop(population, a, c, V, fitnessScoreFunc, inverseFitnessScoreFunc, ...
                     numOfSelections, maxGenerations, tolerance, n, printLogs);

%% Final Plots-Outputs
plotGenerations(bestFitnessScores, inverseFitnessScoreFunc, 'Best');
plotGenerations(meanFitnessScores, inverseFitnessScoreFunc, 'Mean');

% Track best fitness
fprintf('\nConverged at generation %d with best fitness: %e, total time: %f\n', ...
    generation, bestFitness, inverseFitnessScoreFunc(bestFitness));

% Print best chromosome
fprintf('Optimization finished. Best solution found:\n');
disp(bestSolution);

if validateChromosome(bestSolution, c, V)
    fprintf('Resulted Chromosome Valid !!\n');
else
    fprintf('Resulted Chromosome Invalid :(\n');
end
