function input_window = get_user_input(record_types)

font_size = 13;

half_record_count = ceil(size(record_types, 1)/2);
left_inset = 15;
checkbox_width = 250;

% Create figure
input_window.fig = figure('units', 'normalized', 'position', [.3, .4, .4, .4], 'menu', 'none');
set(input_window.fig, 'units', 'pixels')
window_px_sizes = get(input_window.fig, 'position');
window_width = checkbox_width*2 + left_inset*4;
window_height = 105 + (half_record_count + 1)*25;
set(input_window.fig, 'position', [window_px_sizes(1), window_px_sizes(2), window_width, window_height]);
y_pos = window_height;

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
y_pos = y_pos - text_height + 15;

text_height = 18;
uicontrol('Style', 'Text', 'Units', 'Pixels',...
        'Position', [left_inset, y_pos, window_width-30, text_height], 'FontSize', font_size, 'HorizontalAlignment', 'Left',...
        'fontweight', 'bold', 'String', 'Select record types to be plotted:');
y_pos = y_pos - text_height - 5;
    
% Create record checkboxes
for ind = 1:half_record_count
    input_window.record_check_boxes(ind) = uicontrol('Style', 'Checkbox', 'Units', 'Pixels',...
        'Position', [left_inset, y_pos - 25*(ind-1), checkbox_width, 18],...
        'FontSize', font_size, 'String', [char(record_type_names(ind)) ' (' char(record_units(ind)) ')']);
end
for ind = half_record_count+1:size(record_types, 1)
    input_window.record_check_boxes(ind) = uicontrol('Style', 'Checkbox', 'Units', 'Pixels',...
        'Position', [(left_inset*3)+checkbox_width, y_pos - 25*(ind-half_record_count-1), checkbox_width, 18],...
        'FontSize', font_size, 'String', [char(record_type_names(ind)) ' (' char(record_units(ind)) ')']);
end
y_pos = y_pos - (half_record_count+1)*(25);

button_height = 26;
window_pos = input_window.fig.Position;
uicontrol('Style', 'PushButton', 'Units', 'Pixels', 'Position', [(window_width-100)/2, y_pos, 100, button_height],...
        'FontSize', font_size, 'String', 'Proceed', 'Callback', @proceed_button);
        
    function proceed_button(~, ~)
        close gcf;
        uiresume;
    end
    
% % Create date selection text message
% uicontrol('Style', 'Text', 'Units', 'Pixels',...
%         'Position', [left_inset, y_pos, window_width-30, text_height], 'FontSize', font_size, 'HorizontalAlignment', 'Left',...
%         'fontweight', 'bold', 'String', 'Select date range to be plotted:');
% y_pos = y_pos - text_height - 10;
% 
% selector_height = 26;
% uicontrol('Style', 'PopupMenu', 'Position', [left_inset, y_pos, 80, selector_height], 'FontSize', font_size,...
%         'HorizontalAlignment', 'Right', 'String', cellstr(num2str([1:12]'))); %#ok<NBRAK>

% button_height = 26;
% window_pos = input_window.fig.Position;
% uicontrol('Style', 'PushButton', 'Units', 'Pixels', 'Position', [left_inset, y_pos, 120, button_height],...
%         'FontSize', font_size, 'String', 'Set Date Range', 'Callback', {@date_picker, window_pos, dates});
        
%     function date_picker(~, ~, window_pos, dates)
%         figure('Position', [window_pos(1)+100, window_pos(2)+100, window_pos(3)-200, window_pos(4)-200],...
%             'menu', 'none');
%         
%     end
    
%     function date_picker(~, ~, window_pos, dates)
%         f = uifigure('Position', [window_pos(1)+100, window_pos(2)+100, window_pos(3)-200, window_pos(4)-200]);
%         uidatepicker(f);
%     end

end