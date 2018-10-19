input_file_name = 'output.csv';

data = table2cell(readtable(input_file_name, 'Delimiter', ','));
file_handle = fopen(input_file_name);
headers = textscan(file_handle, '%s', size(data, 2));
headers = headers{1}';
fclose(file_handle);

dates = char(data(:, 1));
dates = dates(:, 1:end-length(' -0600'));
values = cell2mat(data(:, 2:2:end));
units = data(:, 3:2:end);

dates = datenum(dates);

fig = scatter(dates, values(:, 1)); 
set(gcf, 'OuterPosition', [81, 200, 1400, 700])
datetick('x', 'yy-mm-dd HH:MM:SS')

ylabel(units(1, 1))

set(gca, 'FontSize', 14)