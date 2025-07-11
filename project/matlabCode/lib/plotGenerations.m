function plotGenerations(prevBestFitnessScores, inverseFitnessScoreFunc, tag)
    % Remove initial -Inf values (if any)
    validIndices = prevBestFitnessScores ~= -Inf;
    fitnessValues = prevBestFitnessScores(validIndices);
    
    % Compute corresponding total time values
    totalTimeValues = arrayfun(inverseFitnessScoreFunc, fitnessValues);

    figure;
    
    % Plot fitness values
    subplot(2,1,1);
    plot(1:1:length(fitnessValues), fitnessValues, 'b', 'LineWidth', 2);
    xlabel('Generation');
    ylabel('Fitness Score');
    title(strcat(tag, ' Fitness Score Over Generations'));
    grid on;

    % Plot total time values
    subplot(2,1,2);
    plot(1:1:length(totalTimeValues), totalTimeValues, 'r', 'LineWidth', 2);
    xlabel('Generation');
    ylabel('Total Time');
    title(strcat(tag, ' Total Time Over Generations'));
    grid on;
end
