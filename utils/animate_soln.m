function animate_soln(board, soln)
%ANIMATE_SOLN accepts a scrambled board object and the solution sequence to
%that board object, and outputs a visualization of the solution.

f = figure; % create the figure
ax = axes('Parent', f, 'position', [0.13 0.2 0.77 0.77]); % fix the axes dimensions

h = imagesc(board.tiles); % main plot function (pretend the int32 Matrix is an image)
for i = 1:size(board.tiles, 1)
    for j = 1:size(board.tiles, 2)
        if board.tiles(i, j) ~= int32(board.num_cols * board.num_rows)
            % name each tile in the image by the number in board.tiles
            % unless its the "blank square"
            text(j, i, num2str(board.tiles(i, j)), 'FontSize', 32)
        end
    end
end

% start with move number "0" representing the starting scrambled board
move_number = 0;

% draw the UI slider control at the bottom of the figure
b = uicontrol('Parent', f, 'Style', 'slider', ...
    'Position', [81,45,419,23], 'value', move_number, 'min', 0, ...
    'max', length(soln));
bgcolor = f.Color;
bl1 = uicontrol('Parent',f,'Style','text','Position',[50,45,23,23],...
                'String','0','BackgroundColor', bgcolor);
bl2 = uicontrol('Parent', f, 'Style', 'text', 'Position', [500,45,23,23],...
                'String', num2str(length(soln)), 'BackgroundColor', bgcolor);
bl3 = uicontrol('Parent', f, 'Style', 'text', 'Position', [240,20,100,23],...
                'String', 'Move Number', 'BackgroundColor', bgcolor);

% create the slider callback function to redraw the figure with updates to
% the slider
b.Callback = @(es,ed) animate_soln_callback(h, board, soln, es.Value);

end