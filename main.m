% Optimization Techniques - Project - main.
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: ...

%% Clean workplace - Initialize Problem
clear; clc; close all;

addpath('src'); addpath('utils');

% populationSize  = 100000;
% numOfSelections = 20000;
populationSize  = 500;
numOfSelections = 300;
chromosomeSize  = 17;
V = 100;
a = [1.25 1.25 1.25 1.25 1.25 1.5 1.5 1.5 1.5 1.5 1 1 1 1 1 1 1];
c = [54.13 21.56 34.08 49.19 33.03 21.84 29.96 24.87 47.24 33.97 26.89 32.76 39.98 37.12 53.83 61.65 59.73];

%% Initialize Population

% Parameters
maxGenerations    = 10000;  % Maximum number of generations
tolerance         = 1e-3;    % Stopping criterion (difference in fitness)
prevFitnessValues = -Inf;    % Track previous best fitness scores
generation        = 0;
printLogs         = false;    % Enable debug logging output to console

% Initialize Population
population = initializePopulation(populationSize, chromosomeSize, c, V);

for i = 1:populationSize
    if ~validateChromosome(population(i, :), c, V)
        error('initializePopulation: Invalid Initial Chromosome');
    end
end

fitnessValues = fitnessFunc(population, a, c);  % Initial Fitness scores

%% Evolution Loop
while generation < maxGenerations
    generation = generation + 1;
    if true
        fprintf('[generation]   ----  %d  ----\n', generation);
    end

    % Selection
    rouletteIndices = rouletteWheelSelection(fitnessValues, numOfSelections);
    population = population(rouletteIndices, :);
    if printLogs
        numUnique = length(unique(rouletteIndices));
        fprintf('[selection] Number of total unique indices:  %d/%d\n', ...
            numUnique, numOfSelections);
    end

    % Crossover
    [population, offspringCount] = crossover(population, c, V);
    if printLogs
        fprintf('[crossover] Number of total new offsprings:  %d/%d\n', ...
            offspringCount, numOfSelections);
    end
    
    % Mutation
    [population, validMutations] = mutation(population, c, V);
    if printLogs
        fprintf('[mutation]  Number of total valid mutations: %d/%d\n', ...
            validMutations, numOfSelections);
    end

    % Evaluate Fitness Scores
    fitnessValues = fitnessFunc(population, a, c);
    [bestFitness, bestIndex] = max(fitnessValues);
    
    % Check stopping criterion
    if 1/nthroot(bestFitness, 5) + 700 <= 792
        break;
    end
    prevFitnessValues = fitnessValues;
end

%% Final Outputs
% Track best fitness
[bestFitness, bestIndex] = max(fitnessValues);
fprintf('Converged at generation %d with best fitness: %e, total time: %f\n', ...
    generation, bestFitness, 1/nthroot(bestFitness, 5) + 700);

% Print best chromosome
bestSolution = population(bestIndex, :);
fprintf('Optimization finished. Best solution found:\n');
disp(bestSolution);
