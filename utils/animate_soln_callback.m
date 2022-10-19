function animate_soln_callback(h, board, soln, move_number)
%ANIMATE_SOLN_CALLBACK updates the animation of the solving of the
%scrambled board object

for i = 1:move_number
    % increment the board we are at to the "move_number" position
    board = board.make_move(soln(i));
end

h = imagesc(board.tiles); % replot the exact same image as in animate_soln
for i = 1:size(board.tiles, 1)
    for j = 1:size(board.tiles, 2)
        if board.tiles(i, j) ~= int32(board.num_cols * board.num_rows)
            % name each tile in the image by the number in board.tiles
            % unless its the "blank square"
            text(j, i, num2str(board.tiles(i, j)), 'FontSize', 32)
        end
    end
end

end