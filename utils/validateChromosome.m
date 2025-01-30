function isValid = validateChromosome(chromosome, cValues, vValue)
    isValid = true;
    tolerance = 1e-3;

    % Check that all values are within the given constraints
    if any(chromosome < 0) || any(chromosome >= cValues)
        isValid = false;
        return;
    end

    % Check if the sum of edges 1 to 4 equals vValue
    if abs(sum(chromosome(1:4)) - vValue) > tolerance
        isValid = false;
        return;
    end
    
    % Check edges 5 and 6 (x5 + x6 = x1)
    if abs(chromosome(5) + chromosome(6) - chromosome(1)) > tolerance
        isValid = false;
        return;
    end

    % Check edges 7 and 8 (x7 + x8 = x2)
    if abs(chromosome(7) + chromosome(8) - chromosome(2)) > tolerance
        isValid = false;
        return;
    end

    % Check edges 9 and 10 (x9 + x10 = x4)
    if abs(chromosome(9) + chromosome(10) - chromosome(4)) > tolerance
        isValid = false;
        return;
    end

    % Check edges 11, 12, and 13 (x11 + x12 + x13 = x9 + x3 + x8)
    if abs(chromosome(11) + chromosome(12) + chromosome(13) - (chromosome(9) + chromosome(3) + chromosome(8))) > tolerance
        isValid = false;
        return;
    end

    % Check edge 17 (x17 = x10 + x11)
    if abs(chromosome(17) - (chromosome(10) + chromosome(11))) > tolerance
        isValid = false;
        return;
    end

    % Check edges 14 and 15(x14 + x15 = x6 + x7 + x13)
    if abs(chromosome(14) + chromosome(15) - (chromosome(6) + chromosome(7) + chromosome(13))) > tolerance
        isValid = false;
        return;
    end

    % Check edge 16 (x16 = x5 + x14)
    if abs(chromosome(16) - (chromosome(5) + chromosome(14))) > tolerance
        isValid = false;
        return;
    end
end
