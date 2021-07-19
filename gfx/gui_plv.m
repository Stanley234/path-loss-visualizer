classdef gui_plv < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure matlab.ui.Figure
        ModelDropDown matlab.ui.control.DropDown
        ModelLabel matlab.ui.control.Label
        SaveButton matlab.ui.control.Button
        ComputeButton matlab.ui.control.Button
        MaxDistancemSlider matlab.ui.control.Slider
        MaxDistancemSliderLabel matlab.ui.control.Label
        HeightRecievermEditField matlab.ui.control.NumericEditField
        HeightRecievermEditFieldLabel matlab.ui.control.Label
        HeightTransmittermEditField matlab.ui.control.NumericEditField
        HeightTransmittermEditFieldLabel matlab.ui.control.Label
        FrequencyHzEditField matlab.ui.control.NumericEditField
        FrequencyHzEditFieldLabel matlab.ui.control.Label
        TerrainEditField matlab.ui.control.NumericEditField
        TerrainEditFieldLabel matlab.ui.control.Label
        UIAxes matlab.ui.control.UIAxes
    end

    properties (Access = public)
        lof
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: ComputeButton, SaveButton
        function ComputeButtonPushed(app, ~)
            model = app.ModelDropDown.Value;
            f = app.FrequencyHzEditField.Value;
            d = linspace(0, app.MaxDistancemSlider.Value, 1000);
            dt = app.HeightTransmittermEditField.Value;
            dr = app.HeightRecievermEditField.Value;
            t = app.TerrainEditField.Value;

            plot(app.UIAxes, d, app.lof{model}(f, d, dt, dr, t));

        end

        function SaveButtonPushed(app, ~)
            filter = {'*.jpg'; '*.png'; '*.tif'; '*.pdf'; '*.eps'};
            [filename, filepath] = uiputfile(filter);

            if ischar(filename)
                exportgraphics(app.UIAxes, [filepath filename]);
            end

        end

    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB Path Loss Visualizer';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Path Loss')
            xlabel(app.UIAxes, 'Distance [m]')
            ylabel(app.UIAxes, 'Path Loss [dB]')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [220 1 420 479];

            % Create TerrainEditFieldLabel
            app.TerrainEditFieldLabel = uilabel(app.UIFigure);
            app.TerrainEditFieldLabel.Position = [10 410 152 22];
            app.TerrainEditFieldLabel.Text = 'Terrain';

            % Create TerrainHzEditField
            app.TerrainEditField = uieditfield(app.UIFigure, 'numeric');
            app.TerrainEditField.Position = [161 410 73 24];

            % Create FrequencyHzEditFieldLabel
            app.FrequencyHzEditFieldLabel = uilabel(app.UIFigure);
            app.FrequencyHzEditFieldLabel.Position = [10 374 152 22];
            app.FrequencyHzEditFieldLabel.Text = 'Frequency [Hz]';

            % Create FrequencyHzEditField
            app.FrequencyHzEditField = uieditfield(app.UIFigure, 'numeric');
            app.FrequencyHzEditField.Position = [161 374 73 24];

            % Create HeightTransmittermEditFieldLabel
            app.HeightTransmittermEditFieldLabel = uilabel(app.UIFigure);
            app.HeightTransmittermEditFieldLabel.Position = [10 338 152 22];
            app.HeightTransmittermEditFieldLabel.Text = 'Height Transmitter [m]';

            % Create HeightTransmittermEditField
            app.HeightTransmittermEditField = uieditfield(app.UIFigure, 'numeric');
            app.HeightTransmittermEditField.Position = [161 338 73 24];

            % Create HeightRecievermEditFieldLabel
            app.HeightRecievermEditFieldLabel = uilabel(app.UIFigure);
            app.HeightRecievermEditFieldLabel.Position = [10 301 152 22];
            app.HeightRecievermEditFieldLabel.Text = 'Height Reciever[m]';

            % Create HeightRecievermEditField
            app.HeightRecievermEditField = uieditfield(app.UIFigure, 'numeric');
            app.HeightRecievermEditField.Position = [161 300 73 24];

            % Create MaxDistancemSliderLabel
            app.MaxDistancemSliderLabel = uilabel(app.UIFigure);
            app.MaxDistancemSliderLabel.HorizontalAlignment = 'right';
            app.MaxDistancemSliderLabel.Position = [13 261 98 22];
            app.MaxDistancemSliderLabel.Text = 'Max Distance [m]';

            % Create MaxDistancemSlider
            app.MaxDistancemSlider = uislider(app.UIFigure);
            app.MaxDistancemSlider.Limits = [1000 10000];
            app.MaxDistancemSlider.Position = [22 238 188 7];
            app.MaxDistancemSlider.Value = 1000;

            % Create ComputeButton
            app.ComputeButton = uibutton(app.UIFigure, 'push');
            app.ComputeButton.ButtonPushedFcn = createCallbackFcn(app, @ComputeButtonPushed, true);
            app.ComputeButton.Position = [9 106 115 41];
            app.ComputeButton.Text = 'Compute';

            % Create SaveButton
            app.SaveButton = uibutton(app.UIFigure, 'push');
            app.SaveButton.ButtonPushedFcn = createCallbackFcn(app, @SaveButtonPushed, true);
            app.SaveButton.Position = [10 50 115 41];
            app.SaveButton.Text = 'Save';

            % Create ModelLabel
            app.ModelLabel = uilabel(app.UIFigure);
            app.ModelLabel.HorizontalAlignment = 'right';
            app.ModelLabel.Position = [9 159 65 22];
            app.ModelLabel.Text = 'Model:';

            % Create ModelDropDown
            app.ModelDropDown = uidropdown(app.UIFigure);
            app.ModelDropDown.Position = [89 154 137 32];
            app.ModelDropDown.Items = ["ECC-33", "COST-231 HATA", "Stanford University Interim", "FSPL"];
            app.ModelDropDown.ItemsData = 1:4;
            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end

    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = gui_plv(lof)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end

            app.lof = lof;
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end

    end

end
