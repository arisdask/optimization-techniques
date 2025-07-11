function selectedIndices = rouletteWheelSelection(fitnessValues, numOfSelections)
    % Normalize fitness values to create a probability distribution
    fitnessSum = sum(fitnessValues);
    probabilities = fitnessValues / fitnessSum;

    % Compute cumulative probabilities (roulette wheel segments)
    cumulativeProbs = cumsum(probabilities);

    % Initialize selection array
    selectedIndices = zeros(numOfSelections, 1);

    % Perform selection for numOfSelections individuals
    for i = 1:1:numOfSelections
        r = rand;
        
        % Find the first index where cumulative probability exceeds r
        selectedIndices(i) = find(cumulativeProbs >= r, 1);
    end
end
