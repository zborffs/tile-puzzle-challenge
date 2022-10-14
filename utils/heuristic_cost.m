function estimated_cost = heuristic_cost(board, label, dest_loc)
%HEURISTIC_COST

% estimated_cost = ...

label_loc = board.find_loc(label);

estimated_cost = abs(label_loc.row - dest_loc.row) + abs(label_loc.col - dest_loc.col) +...
    abs(board.blank_tile.row - label_loc.row) + abs(board.blank_tile.row - label_loc.col);
% estimated_cost = abs(label_loc.row - dest_loc.row) + abs(label_loc.col - dest_loc.col);

end