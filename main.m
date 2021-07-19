%% main func

function [] = main(~)
    %%  init
    clc;
    clear;

    addpath('./gfx');
    addpath('./models');
    % List of Functions implemented
    lof = {@ECC33 @COST231 @SUI @FSPL};
    %% gui
    gfx = gui_plv(lof);

end
