function chromosome = initializeChromosome(chromosomeSize, cValues, vValue)
    chromosome = zeros(1, chromosomeSize);
    
    % Edges 1 to 4 (normalized allocation of total flow V = vValue)
    genes1to4 = zeros(1, 4);

    if sum(cValues(1:4)) < vValue
        error(['initializeChromosome: The sum of cValues(1:4) is less than vValue. ' ...
            'It is impossible to distribute vValue among the four edges while respecting the constraints.']);
    end

    while true
        genes1to4 = rand(1, 4); % Generate 4 raw random values
        genes1to4 = (genes1to4 / sum(genes1to4)) * vValue; % Scale to sum vValue
        
        if all(genes1to4 < cValues(1:4)) && all(genes1to4 >= 0)
            break;
        end
    end
    chromosome(1:4) = genes1to4;

    % Edges 5 and 6 (split from edge 1)
    while true
        gene5 = rand * genes1to4(1);
        gene6 = genes1to4(1) - gene5;
        
        if gene5 < cValues(5) && gene6 < cValues(6) && gene5 >= 0 && gene6 >= 0
            break;
        end
    end
    chromosome(5:6) = [gene5, gene6];

    % Edges 7 and 8 (split from edge 2)
    while true
        gene7 = rand * genes1to4(2);
        gene8 = genes1to4(2) - gene7;
        
        if gene7 < cValues(7) && gene8 < cValues(8) && gene7 >= 0 && gene8 >= 0
            break;
        end
    end
    chromosome(7:8) = [gene7, gene8];

    % Edges 9 and 10 (split from edge 4)
    while true
        gene9  = rand * genes1to4(4);
        gene10 = genes1to4(4) - gene9;
        
        if gene9 < cValues(9) && gene10 < cValues(10) && gene9 >= 0 && gene10 >= 0
            break;
        end
    end
    chromosome(9:10) = [gene9, gene10];

    % Edges 11, 12, and 13 (from 9, 3, and 8)
    sum_11to13 = gene9 + genes1to4(3) + gene8; % x11 + x12 + x13 = x9 + x3 + x8

    while true
        genes11to13 = rand(1, 3);
        genes11to13 = (genes11to13 / sum(genes11to13)) * sum_11to13;
        gene17 = gene10 + genes11to13(1);  % x17 = x10 + x11
        
        if all(genes11to13 < cValues(11:13)) && gene17 < cValues(17) && all(genes11to13 >= 0) && gene17 >= 0
            break;
        end
    end
    chromosome(11:13) = genes11to13;
    chromosome(17) = gene17;

    % Edges 14, 15 (from 6, 7, and 13)
    sum_14to15 = gene6 + gene7 + genes11to13(3); % x14 + x15 = x6 + x7 + x13

    while true
        gene14 = rand * sum_14to15;
        gene15 = sum_14to15 - gene14;
        gene16 = gene5 + gene14;  % x16 = x5 + x14
        
        if gene14 < cValues(14) && gene15 < cValues(15) && gene16 < cValues(16) && ...
           gene14 >= 0 && gene15 >= 0 && gene16 >= 0
            break;
        end
    end
    chromosome(14:16) = [gene14, gene15, gene16];

end
