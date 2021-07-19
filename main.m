%% main func

function [out] = main(~)
    %%  init
    clc;
    clear;

    addpath('./gfx');
    addpath('./models');
    addpath('./util');
    % List of Functions implemented
    lof = {@ECC33 @COST231 @SUI @FSPL};
    %% gui
    out = gui_plv(lof);
    
end
