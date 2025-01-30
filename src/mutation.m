function [mutatedPopulation, validMutations] = mutation(population, cValues, vValue)
    mutationRate = 0.1; % Probability of mutating each chromosome
    sigma = 0.05; % Standard deviation for Gaussian mutation
    numOfIndividuals = size(population, 1);
    chromosomeSize = size(population, 2);
    
    mutatedPopulation = population; % Copy original population
    validMutations = 0; % Counter for valid mutations

    for i = 1:numOfIndividuals
        if rand < mutationRate
            chromosome = population(i, :); % Select chromosome to mutate
            numMutations = randi([1, 4]); % Random number of genes to mutate
            
            % Select random genes to mutate
            mutationIndices = randperm(chromosomeSize, numMutations);
            
            % Apply mutation
            mutationValues = (rand(1, numMutations) - 0.5) .* normrnd(0, sigma, 1, numMutations);
            chromosome(mutationIndices) = chromosome(mutationIndices) + mutationValues;
            
            % Normalize to maintain sum constraint
            chromosome = (chromosome / sum(chromosome)) * vValue;
            
            % Ensure chromosome meets constraints
            if validateChromosome(chromosome, cValues, vValue)
                mutatedPopulation(i, :) = chromosome;
                validMutations = validMutations + 1; % Increment valid mutation count
            end
        end
    end
end
