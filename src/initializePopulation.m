function population = initializePopulation(popSize, chromosomeSize, cValues, vValue)
    population = zeros(popSize, chromosomeSize);

    for i = 1:1:popSize
        population(i, :) = initializeChromosome(chromosomeSize, cValues, vValue);
    end
end
