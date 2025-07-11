function [newPopulation, offspringCount] = crossover(population, cValues, vValue)
    numIndividuals = size(population, 1);
    chromosomeSize = size(population, 2);
    
    % Initialize new population (same size as original)
    newPopulation = zeros(numIndividuals, chromosomeSize);
    offspringCount = 0; % Counter for total valid crossovers

    % Perform crossover for each new offspring
    for i = 1:1:numIndividuals
        % Select two random parents
        idx1 = randi(numIndividuals);
        idx2 = randi(numIndividuals);

        while chromosomeSize == 18 && (idx1 == idx2 || ...
             abs(population(idx1, chromosomeSize) - population(idx2, chromosomeSize)) > 1.5)
            idx1 = randi(numIndividuals);
            idx2 = randi(numIndividuals);
        end
        
        % Ensure we pick two different parents
        while idx1 == idx2
            idx2 = randi(numIndividuals);
        end
        
        parent1 = population(idx1, :);
        parent2 = population(idx2, :);

        % Perform arithmetic crossover (element-wise averaging)
        offspring = (parent1 + parent2) / 2;

        % If chromosomeSize = 18, then offspring(chromosomeSize) is the V value to validate
        V = vValue + (chromosomeSize == 18) .* (offspring(chromosomeSize) - vValue);

        % Check validity; 20% chance of not performing crossover
        if validateChromosome(offspring(1:17), cValues, V) && rand > 0.2
            newPopulation(i, :) = offspring;
            offspringCount = offspringCount + 1;
        else
            % Revert to one of the parents
            newPopulation(i, :) = parent1;
        end
    end
end
