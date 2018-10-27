function get_user_input(record_types)

font_size = 13;

% Create figure
input_window.fig = figure('units', 'normalized', 'position', [.3, .5, .4, .5], 'menu', 'none');

set(input_window.fig, 'units', 'pixels')
window_px_sizes = get(input_window.fig, 'position');
window_width = window_px_sizes(3);
window_height = window_px_sizes(4);
y_pos = window_height;
left_inset = 15;

% Create checkboxes
record_type_names = table2cell(record_types(:, 1));
record_type_names = strrep(record_type_names, 'HKQuantityTypeIdentifier', '');
record_units = table2cell(record_types(:, 2));

% Create record selection text message
message_str = 'For an explination of record types, see: https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier';

text_height = 36;
y_pos = y_pos - text_height - left_inset;
uicontrol('Style', 'Text', 'Units', 'Pixels',...
        'Position', [15, y_pos, window_width-30, text_height], 'FontSize', font_size, 'HorizontalAlignment', 'Left',...
        'String', message_str);

text_height = 18;
y_pos = y_pos - text_height - 5;
uicontrol('Style', 'Text', 'Units', 'Pixels',...
        'Position', [left_inset, y_pos, window_width-30, text_height], 'FontSize', font_size, 'HorizontalAlignment', 'Left',...
        'fontweight', 'bold', 'String', 'Select record types to be plotted:');

% Create record checkboxes
half_record_count = ceil(size(record_types, 1)/2);
for ind = 1:half_record_count
    input_window.record_check_boxes(1) = uicontrol('Style', 'Checkbox', 'Units', 'Pixels',...
        'Position', [left_inset, y_pos - 25*(ind), 250, 18], 'FontSize', font_size,...
        'String', [char(record_type_names(ind)) ' (' char(record_units(ind)) ')']);
end
for ind = half_record_count+1:size(record_types, 1)
    input_window.record_check_boxes(1) = uicontrol('Style', 'Checkbox', 'Units', 'Pixels',...
        'Position', [left_inset+295, y_pos - 25*(ind-half_record_count), 250, 18], 'FontSize', font_size,...
        'String', [char(record_type_names(ind)) ' (' char(record_units(ind)) ')']);
end
y_pos = y_pos - (half_record_count+1)*(25);

% Create date selection text message
uicontrol('Style', 'Text', 'Units', 'Pixels',...
        'Position', [left_inset, y_pos, window_width-30, text_height], 'FontSize', font_size, 'HorizontalAlignment', 'Left',...
        'fontweight', 'bold', 'String', 'Select date range to be plotted:');
end