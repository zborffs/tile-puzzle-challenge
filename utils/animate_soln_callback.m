function animate_soln_callback(h, board, soln, move_number)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

for i = 1:move_number
    board = board.make_move(soln(i));
end

h = imagesc(board.tiles);
for i = 1:size(board.tiles, 1)
    for j = 1:size(board.tiles, 2)
        if board.tiles(i, j) ~= int32(9)
            text(j, i, num2str(board.tiles(i, j)), 'FontSize', 32)
        end
    end
end

% for i = 1:move_number
%     board.unmake_move();
% end

end