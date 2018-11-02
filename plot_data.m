close all;
clear;

fprintf('\nWelcome.\n');

% input_file_name = 'output.csv';
include_seconds_in_x_axis_labels = false;
x_tick_step = .25; % 1 = 1 day, 0.25 = 6 hours
% x_tick_label_format = 'yy-mm-dd HH:MM::SS';
x_tick_label_format = 'mm/dd HH PM';

% Get data file path
if ~exist('input_file_name', 'var')
    fprintf('Please select a file (with a ''.csv'' extension) to process...\n');
    [input_file_name, input_file_path] = uigetfile('*.csv');
    input_file_name = [input_file_path, input_file_name];
end

% Check if file exists, if not give error message and exit
if exist(input_file_name, 'file') ~= 2
    err_str = sprintf('ERROR: Specified input file ''%s'' could not be found.\nExiting.', input_file_name);
    msgbox(err_str)
    fprintf('\n%s\n\n', err_str);    
    return;
end

fprintf('Opening file and determining record types...\n');

% Read in data
data = readtable(input_file_name, 'Delimiter', ',', 'ReadVariableNames', true, 'HeaderLines', 0);
headers = data.Properties.VariableNames;

% Create record and unit table
[record_types, ia, ~] = unique(data.(char(headers(1)))); % Find unique record types
record_types(:, 2) = data.(char(headers(4)))(ia); % Find units associated with record types
record_types = cell2table(record_types, 'VariableNames', {char(headers(1)), char(headers(4))});

% Have user select which record types to keep
fprintf('Please select record types to plot...\n');
get_user_input(record_types); % Retuns check box booleans as 'user_input'
uiwait(user_input_figure);  % Wait until user input window has been closed

% Exit if no record types were selected
if ~exist('user_input', 'var') || sum(user_input) == 0
    fprintf('\nNo record types selected.\nExiting.\n\n')
    return;
end

fprintf('Processing data...\n');

% Keep only selected records
record_types = record_types(user_input, :);
data = data(ismember(data.(char(headers(1))), record_types.(char(headers(1)))), :);

% Get dates as strings, remove UTC offsets, convert to numeric values
dates = data.(char(headers(2)));
regex = ' [-+±]\d\d\d\d';
dates = regexprep(dates, regex, ''); % Remove UTC offsets and convert to char
dates = datenum(dates);

% Get min and max dates based on user selected record types
min_date = min(dates);
max_date = max(dates);

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
for data_ind = 2:2:size(data, 2)
    scatter(dates, data.(char(headers(data_ind))));
    unit_name = char(data.(char(data.Properties.VariableNames(data_ind+1)))(1));  % Get unit as first element in unit column
    ylabel(sprintf('%s (%s)', char(headers(data_ind)), unit_name));
end

% Format x-axis tick labels
ax = gca;
set(gca, 'XTickLabelRotation', 30, 'XTick', ax.XLim(1):x_tick_step:ax.XLim(2))
datetick('x', x_tick_label_format, 'keepticks')

% Save figure and close
% saveas(gcf, 'plot.png')
% close(gcf)