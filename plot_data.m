close all;
clear;

input_file_name = 'output.csv';
include_seconds_in_x_axis_labels = false;
x_tick_step = .25; % 1 = 1 day, 0.25 = 6 hours
% x_tick_label_format = 'yy-mm-dd HH:MM::SS';
x_tick_label_format = 'mm/dd HH PM';

% Check if file exists, if not give error message and exit
if exist(input_file_name, 'file') ~= 2
    msgbox('ERROR: Specified input file could not be found. Exiting.')
    return;
end

% Read in data
data = readtable(input_file_name, 'Delimiter', ',', 'ReadVariableNames', true, 'HeaderLines', 0);
headers = data.Properties.VariableNames;

% Get dates as strings, remove timezone information, convert to numeric values
dates = char(data.(char(headers(1))));
dates = dates(:, 1:end-length(' -0600'));
dates = datenum(dates);

% Setup plot
data_plot = figure;
data_ax = axes;
set(gcf, 'units', 'normalized', 'OuterPosition', [.05 .1 .9 .8])
% set(gcf, 'units', 'normalized', 'OuterPosition', [.05 .1 .1 .1])
set(gca, 'Position', [0.07 0.12 0.88 0.815])
grid on
hold on
set(gca, 'FontSize', 14)
xlabel(data.Properties.VariableNames(1))

% Plot each value type as separate series
% for data_ind = 2:2:size(data(2))
data_ind = 2
    plot(dates, data.(char(headers(data_ind))));
    unit_name = char(data.(char(data.Properties.VariableNames(data_ind+1)))(1));  % Get unit as first element in unit column
    ylabel(sprintf('%s (%s)', char(headers(data_ind)), unit_name));
% end

% Format x-axis tick labels
ax = gca;
set(gca, 'XTickLabelRotation', 30, 'XTick', ax.XLim(1):x_tick_step:ax.XLim(2))
datetick('x', x_tick_label_format, 'keepticks')

% Save figure and close
saveas(gcf, 'plot.png')
close(gcf)