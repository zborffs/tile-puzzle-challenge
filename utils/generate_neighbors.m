function [neighbors] = generate_neighbors(board, immovable_locs)
%GENERATE_NEIGHBORS returns all the moves which we can make from the
%current board configuration

% Initialize the neighbors vector as empty.
neighbors = [];

% Try moving "up" (recall moving "up" means incrementing "blank_tile" row 
% by 1)
up_candidate = Node(board.blank_tile.row + 1, board.blank_tile.col);
if (board.is_tile_on_board(up_candidate) && ~isKey(immovable_locs, jsonencode(up_candidate)))

    % if the candidate move is a valid move, add it to the "neighbors" list
    neighbors = [neighbors; board.make_move(Move.up)]; % MATLAB syntax for pushing element onto vector

end

% Try moving "down" (recall moving "down" means decrementing "blank_tile"
% row by 1)
down_candidate = Node(board.blank_tile.row - 1, board.blank_tile.col);
if (board.is_tile_on_board(down_candidate) && ~isKey(immovable_locs, jsonencode(down_candidate)))

    % if the candidate move is a valid move, add it to the "neighbors" list
    neighbors = [neighbors; board.make_move(Move.down)];

end

% Try moving "right" (recall moving "right" means decrementing "blank_tile"
% column by 1)
right_candidate = Node(board.blank_tile.row, board.blank_tile.col - 1);
if (board.is_tile_on_board(right_candidate) && ~isKey(immovable_locs, jsonencode(right_candidate)))

    % if the candidate move is a valid move, add it to the "neighbors" list
    neighbors = [neighbors; board.make_move(Move.right)];

end

% Try moving "left" (recall moving "left" means incrementing "blank_tile"
% column by 1)
left_candidate = Node(board.blank_tile.row, board.blank_tile.col + 1);
if (board.is_tile_on_board(left_candidate) && ~isKey(immovable_locs, jsonencode(left_candidate)))

    % if the candidate move is a valid move, add it to the "neighbors" list
    neighbors = [neighbors; board.make_move(Move.left)];

end

end