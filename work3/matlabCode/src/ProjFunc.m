% Optimization Techniques - Work 3 - ProjFunc
% Author: Aristeidis Daskalopoulos (AEM: 10640)
% info: This is the implementation of the Projection Function.

function [x_p] = ProjFunc(x, SetLimits)
% ProjFunc projects a vector x onto a defined set, returning the closest 
% point in the set to the input vector.
%
% Inputs:
%   x          A vector to be projected.
%   SetLimits  A matrix defining the limits of the set for each dimension.
%              Each row corresponds to a dimension, with the first column 
%              as the lower bound and the second column as the upper bound.
%
% Outputs:
%   x_p        The projected vector, where each component of x is 
%              constrained to fall within the specified limits.

    x_p = x;
    for i = 1:size(SetLimits, 1)
        % If the value is below the lower limit, set it to the lower limit
        if x(i) < SetLimits(i, 1)
            x_p(i) = SetLimits(i, 1);
        % If the value is above the upper limit, set it to the upper limit
        elseif x(i) > SetLimits(i, 2)
            x_p(i) = SetLimits(i, 2);
        end
    end
end
