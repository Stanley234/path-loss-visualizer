%COST231  path loss according to COST231 model
% frequency = set frequency in Hz
% distance = distance in m (can be vector)
% height_ant = height of antenna in m
% height_rec = height of recieving antenna in m
% terrain = var for differant terrain types
%           0 = rural
%           1 = urban
function [pathloss] = COST231(frequency, distance, height_ant, height_rec, terrain, varargin)

    validateattributes(frequency, {'numeric'}, {'real', 'vector', 'nonnegative'});
    validateattributes(distance, {'numeric'}, {'real', 'vector', 'nonnegative'});
    validateattributes(height_ant, {'numeric'}, {'real', 'vector', 'nonnegative'});
    validateattributes(height_rec, {'numeric'}, {'real', 'vector', 'nonnegative'});
    validateattributes(terrain, {'numeric'}, {'real', 'vector', 'nonnegative'});

    frequency = frequency / (1e6);

    if terrain == 1
        x = 3;
        ahm = 3.2 * pow2(log10(11.75 * height_rec)) - 4.97;
    else
        x = 0;
        ahm = (1.1 * log10(frequency) - 0.7) * height_rec - (1.56 * log10(frequency) - 0.8);
    end

    pathloss = 46.3 + 33.9 * log10(frequency) - 13.82 * log10(height_ant) - ahm + (44.9 - 6.55 * log10(height_ant)) * log10(distance) + x;

end

% [EOF]
