function [sequence, num_nodes_searched] = A_star_search(board, label, end_loc, immovable_locs)
%A_STAR_SEARCH this function should implement your A* algorithm. You must
%return a sequence of "Move" objects in a vector as well as the number of
%nodes you have searched altogether.

% Step 1: Construct helpful function handler
h = @(n) heuristic_cost(n, label, end_loc);

% Step 2: Initialize the solution
sequence = [];
num_nodes_searched = 0;

% Step 3: Initialize local variables for the search
open_set = [board];
came_from = containers.Map;
g_score = containers.Map([jsonencode(board.tiles)], [0]);
f_score = containers.Map([jsonencode(board.tiles)], [h(board)]);


% while ~isempty(open_set)
    % your implementation here...
% end

end