function [mutatedPopulation, validMutations] = mutation(population, cValues, vValue)
    mutationRate = 0.25;  % Probability of mutating a chromosome
    sigma = 0.5;          % Standard deviation for small mutations
    numIndividuals = size(population, 1);
    
    mutatedPopulation = population;  % Copy original population
    validMutations = 0;  % Counter for valid mutations

    for i = 1:numIndividuals
        if rand < mutationRate
            chromosome = population(i, :);  % Select chromosome to mutate
            
            % Mutate edges 1-4 with small Gaussian noise
            while true
                genes1to4 = chromosome(1:4) + normrnd(0, sigma, 1, 4);
                genes1to4 = (genes1to4 / sum(genes1to4)) * vValue;
                if all(genes1to4 < cValues(1:4)) && all(genes1to4 >= 0)
                    break;
                end
            end
            chromosome(1:4) = genes1to4;

            % Mutate edges 5 and 6 (split from edge 1)
            while true
                mutationFactor = normrnd(0, sigma);  % Small change
                gene5 = chromosome(5) + mutationFactor;
                gene6 = genes1to4(1) - gene5;
                if gene5 < cValues(5) && gene6 < cValues(6) && gene5 >= 0 && gene6 >= 0
                    break;
                end
            end
            chromosome(5:6) = [gene5, gene6];

            % Mutate edges 7 and 8 (split from edge 2)
            while true
                mutationFactor = normrnd(0, sigma);  
                gene7 = chromosome(7) + mutationFactor;
                gene8 = genes1to4(2) - gene7;
                if gene7 < cValues(7) && gene8 < cValues(8) && gene7 >= 0 && gene8 >= 0
                    break;
                end
            end
            chromosome(7:8) = [gene7, gene8];

            % Mutate edges 9 and 10 (split from edge 4)
            while true
                mutationFactor = normrnd(0, sigma);  
                gene9 = chromosome(9) + mutationFactor;
                gene10 = genes1to4(4) - gene9;
                if gene9 < cValues(9) && gene10 < cValues(10) && gene9 >= 0 && gene10 >= 0
                    break;
                end
            end
            chromosome(9:10) = [gene9, gene10];

            % Mutate edges 11, 12, 13 (dependent on 9, 3, 8)
            sum_11to13 = gene9 + genes1to4(3) + gene8;
            while true
                mutationFactors = normrnd(0, sigma, 1, 3);
                genes11to13 = (chromosome(11:13) + mutationFactors) / sum(chromosome(11:13) + mutationFactors) * sum_11to13;
                gene17 = gene10 + genes11to13(1);  % x17 = x10 + x11
                if all(genes11to13 < cValues(11:13)) && gene17 < cValues(17) && all(genes11to13 >= 0) && gene17 >= 0
                    break;
                end
            end
            chromosome(11:13) = genes11to13;
            chromosome(17) = gene17;

            % Mutate edges 14, 15, 16 (split from edges 6, 7, 13)
            sum_14to15 = gene6 + gene7 + genes11to13(3);
            while true
                mutationFactor = normrnd(0, sigma);  
                gene14 = chromosome(14) + mutationFactor;
                gene15 = sum_14to15 - gene14;
                gene16 = gene5 + gene14;  % x16 = x5 + x14
                if gene14 < cValues(14) && gene15 < cValues(15) && gene16 < cValues(16) && ...
                   gene14 >= 0 && gene15 >= 0 && gene16 >= 0
                    break;
                end
            end
            chromosome(14:16) = [gene14, gene15, gene16];

            % Validate and store mutation
            if validateChromosome(chromosome, cValues, vValue)
                mutatedPopulation(i, :) = chromosome;
                validMutations = validMutations + 1;
            end
        end
    end
end
