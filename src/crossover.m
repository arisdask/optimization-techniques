function [newPopulation, validCount] = crossover(population, cValues, vValue)
    numIndividuals = size(population, 1);
    
    % Ensure the number of individuals is even
    if mod(numIndividuals, 2) ~= 0
        error('Population size must be even for crossover pairing.');
    end

    halfPopSize = numIndividuals / 2;

    % Initialize new population (half of original size)
    newPopulation = zeros(halfPopSize, size(population, 2));
    validCount = 0; % Counter for valid offspring

    % Loop through pairs and perform crossover
    for i = 1:halfPopSize
        parent1 = population(2*i - 1, :); % Parent 1
        parent2 = population(2*i, :);     % Parent 2

        % Perform arithmetic crossover (element-wise averaging)
        offspring = (parent1 + parent2) / 2;

        % Check validity, revert if invalid
        if validateChromosome(offspring, cValues, vValue)
            newPopulation(i, :) = offspring;
            validCount = validCount + 1; % Increment valid offspring count
        else
            % Revert to parent 1 if offspring is invalid
            newPopulation(i, :) = parent1;
        end
    end
end
