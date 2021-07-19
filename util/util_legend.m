%util_legend  path loss according to COST231 model
% frequency = set frequency in Hz
% distance = distance in m (can be vector)
% height_ant = height of antenna in m
% height_rec = height of recieving antenna in m
% terrain = var for differant terrain types
%           0 = rural
%           1 = urban
function [legend] = util_legend(legend, model, frequency, terrain, keep)
    if keep == 0
        legend(:) = [];
    end

    new_legend = '';

    switch model
        case 1
            new_legend = strcat(new_legend ,'ECC33');
        case 2
            new_legend = strcat(new_legend, 'COST231');
        case 3
            new_legend = strcat(new_legend, 'SUI');
        case 4
            new_legend = strcat(new_legend, 'FSPL');
    end

    if terrain == 0
        new_legend = strcat(new_legend, sprintf('\t RURAl'));
    else
        new_legend = strcat(new_legend, sprintf('\t URBAN'));
    end

    new_legend = strcat(new_legend, sprintf('\t%0.3e', frequency));

    legend{end+1}=new_legend;
end

% [EOF]