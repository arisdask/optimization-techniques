% Optimization Techniques - Project - main.
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: ...

%% Clean workplace - Initialize Problem
clear; clc; close all;

addpath('src'); addpath('utils');

% populationSize = 100000;
% numOfSelections = 20000;
populationSize = 10;
numOfSelections = 6;
chromosomeSize = 17;
V = 100;
a = [1.25 1.25 1.25 1.25 1.25 1.5 1.5 1.5 1.5 1.5 1 1 1 1 1 1 1];
c = [54.13 21.56 34.08 49.19 33.03 21.84 29.96 24.87 47.24 33.97 26.89 32.76 39.98 37.12 53.83 61.65 59.73];

%% Initialize Population

% Parameters
maxGenerations = 10000;  % Maximum number of generations to prevent infinite loops
tolerance = 1e-6;       % Stopping criterion (difference in best fitness)
prevBestFitness = -Inf;  % Track previous best fitness
generation = 0;

% Initialize Population
population = initializePopulation(populationSize, chromosomeSize, c, V);

for i = 1:populationSize
    if ~validateChromosome(population(i, :), c, V)
        error('initializePopulation: Invalid Initial Chromosome');
    end
end

% Evolution Loop
while generation < maxGenerations
    generation = generation + 1;

    % Evaluate fitness
    fitnessValues = fitnessFunc(population, a, c);
    
    % Track best fitness
    [bestFitness, bestIndex] = max(fitnessValues);
    
    % Check stopping criterion
    % if abs((prevBestFitness - bestFitness) / bestFitness) < tolerance
    %     fprintf('Converged at generation %d with best fitness: %f, total time: %f\n', generation, bestFitness, 1/bestFitness);
    %     break;
    % end
    prevBestFitness = bestFitness;
    
    % Selection
    indices = rouletteWheelSelection(fitnessValues, numOfSelections);
    population = population(indices, :);

    % Crossover
    [population, validOffspring] = crossover(population, c, V);
    fprintf('Number of valid offspring: %d\n', validOffspring);

    
    % Mutation
    [population, validMutations] = mutation(population, c, V);
    fprintf('Number of valid mutations: %d\n', validMutations);

end

% Final Output
bestSolution = population(bestIndex, :);
fprintf('Optimization finished. Best solution found:\n');
disp(bestSolution);

fprintf('Converged at generation %d with best fitness: %f, total time: %f\n', generation, bestFitness, 1/bestFitness);

