function fitnessValues = fitnessFunc(population, aValues, cValues)
    % Number of individuals in the population
    popSize  = size(population, 1);
    numEdges = length(cValues);
    
    % Initialize fitness array
    fitnessValues = zeros(popSize, 1);
    
    % Loop through each chromosome (individual in the population)
    for i = 1:1:popSize
        chromosome = population(i, :);
        totalTime = 0;
        
        % Calculate total travel time across all edges
        for j = 1:1:numEdges
            x = chromosome(j);
            c = cValues(j);
            a = aValues(j);
            
            % Ensure denominator doesn't go to zero
            if x >= c
                totalTime = Inf; % Extreme penalty for invalid cases
                break;
            end
            
            % Compute travel time for edge j
            T = (a * x) / (1 - (x / c));
            totalTime = totalTime + T;
        end
        
        % Fitness value (lower time is better)
        fitnessValues(i) = 1 / totalTime;
    end
end
