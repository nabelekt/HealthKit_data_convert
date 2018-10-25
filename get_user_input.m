function get_user_input(record_types)

font_size = 13;

% Create figure
input_window.fig = figure('units', 'normalized', 'position', [.3, .5, .4, .3], 'menu', 'none');

set(input_window.fig, 'units', 'pixels')
window_px_sizes = get(input_window.fig, 'position');
window_width = window_px_sizes(3);
window_height = window_px_sizes(4);

% Create checkboxes
record_type_names = table2cell(record_types(:, 1));
record_type_names = strrep(record_type_names, 'HKQuantityTypeIdentifier', '');
record_units = table2cell(record_types(:, 2));

message_str = 'For an explination of record types,\nsee https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier';

input_window.record_check_boxes(1) = uicontrol('Style', 'Text', 'Units', 'Pixels',...
        'Position', [15, window_height - 30, window_width-30, 18], 'FontSize', font_size, 'HorizontalAlignment', 'Left',...
        'String', message_str);

for ind = 1:size(record_types, 1)
    input_window.record_check_boxes(1) = uicontrol('Style', 'Checkbox', 'Units', 'Pixels',...
        'Position', [15, window_height - 30*(ind+1), 250, 18], 'FontSize', font_size,...
        'String', [char(record_type_names(ind)) ' (' char(record_units(ind)) ')']);
end


end