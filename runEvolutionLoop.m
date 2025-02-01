function [population, bestFitness, bestSolution, generation, bestFitnessScores, meanFitnessScores] = ...
    runEvolutionLoop(population, aValues, cValues, vValue, fitnessScoreFunc, inverseFitnessScoreFunc, ...
                     numOfSelections, maxGenerations, tolerance, n, printLogs)
    
    % Initialize variables
    % populationSize = size(population, 1);
    bestFitnessScores = -Inf * ones(maxGenerations, 1); % Track previous best fitness scores
    meanFitnessScores = -Inf * ones(maxGenerations, 1); % Track previous mean fitness scores
    generation = 0;

    % Initial Fitness scores
    fitnessValues = fitnessFunc(population, aValues, cValues, fitnessScoreFunc);

    % Evolution Loop
    while generation < maxGenerations
        generation = generation + 1;
        fprintf('[generation]   ----  %d  ----\n', generation);

        % Selection
        rouletteIndices = rouletteWheelSelection(fitnessValues, numOfSelections);
        population = population(rouletteIndices, :);
        if printLogs
            numUnique = length(unique(rouletteIndices));
            fprintf('[selection]  Number of total unique indices:  %d/%d\n', ...
                numUnique, numOfSelections);
        end

        % Crossover
        [population, offspringCount] = crossover(population, cValues, vValue);
        if printLogs
            fprintf('[crossover]  Number of total new offsprings:  %d/%d\n', ...
                offspringCount, numOfSelections);
        end

        % Mutation
        [population, validMutations] = mutation(population, cValues, vValue);
        if printLogs
            fprintf('[mutation]   Number of total valid mutations: %d/%d\n', ...
                validMutations, numOfSelections);

            numUniqueChromosomes = size(unique(population, 'rows'), 1);
            fprintf('[population] Number of unique chromosomes:    %d/%d\n', ...
                numUniqueChromosomes, numOfSelections);
        end

        % Evaluate Fitness Scores
        fitnessValues = fitnessFunc(population, aValues, cValues, fitnessScoreFunc);
        [bestFitness, bestIndex] = max(fitnessValues);
    
        % Check stopping criterion
        % if generation > n && ...
        %         abs( ...
        %         inverseFitnessScoreFunc(bestFitness) - inverseFitnessScoreFunc(mean(prevBestFitnessScores((generation - n):(generation - 1)))) ...
        %         ) <= tolerance
        %     break;
        % end
        if generation > n && std( ...
                arrayfun(inverseFitnessScoreFunc, bestFitnessScores((generation - n):(generation - 1))) ...
                ) <= tolerance
            break;
        end
        bestFitnessScores(generation) = bestFitness;
        meanFitnessScores(generation) = mean(fitnessValues);
    end

    % Final Outputs
    bestSolution = population(bestIndex, :);
end
