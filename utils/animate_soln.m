function animate_soln(board, soln)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

f = figure;
ax = axes('Parent', f, 'position', [0.13 0.2 0.77 0.77]);

h = imagesc(board.tiles);
for i = 1:size(board.tiles, 1)
    for j = 1:size(board.tiles, 2)
        if board.tiles(i, j) ~= int32(9)
            text(j, i, num2str(board.tiles(i, j)), 'FontSize', 32)
        end
    end
end

move_number = 0;
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

b.Callback = @(es,ed) animate_soln_callback(h, board, soln, es.Value);

end