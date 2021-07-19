%SUI  path loss according to SUI model
% frequency = set frequency in Hz
% distance = distance in m (can be vector)
% height_ant = height of antenna in m
% height_rec = height of recieving antenna in m
% terrain = var for differant terrain types
%           0 = rural
%           1 = urban
function [pathloss] = SUI(frequency, distance, height_ant, height_rec, terrain, varargin)
    validateattributes(frequency, {'numeric'}, {'real', 'vector', 'nonnegative'});
    validateattributes(distance, {'numeric'}, {'real', 'vector', 'nonnegative'});
    validateattributes(height_ant, {'numeric'}, {'real', 'vector', 'nonnegative'});
    validateattributes(height_rec, {'numeric'}, {'real', 'vector', 'nonnegative'});
    validateattributes(terrain, {'numeric'}, {'real', 'vector', 'nonnegative'});

    d0 = 100; % standard distance
    c = physconst('lightspeed');
    lambda = frequency / c;
    frequency = frequency / (1e6);

    if terrain == 0
        a = 4.6;
        b = 0.0075;
        c = 12.6;
        Xh = -10.8 * log10(height_rec / 2000);
        alpha = 6.6;
    else
        a = 3.6;
        b = 0.005;
        c = 20;
        Xh = -20 * log10(height_rec / 2000);
        alpha = 5.2;

    end

    S = 0.65 * (pow2(log10(frequency))) - 1.3 * log10(frequency) + alpha;
    gamma = a - (b * height_ant) + (c / height_ant);
    A = 20 * log10((4 * pi * d0) / lambda);
    Xf = 6 * log10(frequency / 2000);

    pathloss = A + 10 * gamma * log10(distance / d0) + Xh + S;

    if frequency >= 2
        pathloss = pathloss + Xf;
    end

end

% [EOF]
