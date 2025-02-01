function population = initializePopulationRandV(popSize, chromosomeSize, cValues, vInitialValue)
    population = zeros(popSize, chromosomeSize);

    for i = 1:1:popSize
        vRand = vInitialValue * (1 + (rand - 0.5) * 0.3);  % plus or minus 15% from the initial value
        population(i, 1:(chromosomeSize-1)) = initializeChromosome(chromosomeSize-1, cValues, vRand);
        % From 1 to 17 we have x1 to x17 and at position 18 we add to the chromosome the random V value
        population(i, chromosomeSize) = vRand;
    end
end
