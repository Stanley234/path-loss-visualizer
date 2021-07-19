%ECC33  path loss according to ECC33 model
% frequency = set frequency in Hz
% distance = distance in m (can be vector)
% height_ant = height of antenna in m
% height_rec = height of recieving antenna in m
% terrain = var for differant terrain types
%           0 = rural
%           1 = urban
function [pathloss] = ECC33(frequency, distance, height_ant, height_rec, terrain, varargin)
    validateattributes(frequency, {'numeric'}, {'real', 'vector', 'nonnegative'});
    validateattributes(distance, {'numeric'}, {'real', 'vector', 'nonnegative'});
    validateattributes(height_ant, {'numeric'}, {'real', 'vector', 'nonnegative'});
    validateattributes(height_rec, {'numeric'}, {'real', 'vector', 'nonnegative'});
    validateattributes(terrain, {'numeric'}, {'real', 'vector', 'nonnegative'});

    frequency = frequency / 1e6;
    Afs = 92.4 + 20 * log10(distance) + 20 * log10(frequency);
    Abm = 20.41 + 9.83 * log10(distance) + 7.894 * log10(frequency) + 9.56 * pow2(log10(frequency));
    Gb = log10(height_ant / 200) * (13.958 + 5.8 * pow2(log10(distance)));

    if terrain == 0
        Gr = 0.759 * height_rec - 1.862;
    else
        Gr = (42.57 + 13.7 * log10(frequency)) * (log10(height_rec) - 0.585);
    end

    pathloss = Afs + Abm - Gb - Gr;
end

% [EOF]
