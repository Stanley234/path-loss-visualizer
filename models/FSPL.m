%FSPL  path loss according to FSPL model
% frequency = set frequency in Hz
% distance = distance in m (can be vector)
function [pathloss] = FSPL(frequency, distance, varargin)
    validateattributes(frequency, {'numeric'}, {'real', 'vector', 'nonnegative'});
    validateattributes(distance, {'numeric'}, {'real', 'vector', 'nonnegative'});

    frequency = frequency / (1e6);
    pathloss = -27.55 + 20 * log10(frequency) + 20 * log10(distance);
end

% [EOF]
