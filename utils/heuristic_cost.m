function estimated_cost = heuristic_cost(board, label, dest_loc)
%HEURISTIC_COST this represents the heuristic cost function we define in A*
%search. You must return an estimated cost-to-go from the Node labelled
%"label" to the Node "dest_loc". The board object contains information
%about where the "label" is on the board.

label_loc = board.find_loc(label); % the Node labelled "label"

% Hint: What's the fewest number of hops it takes to get from 1 node to
% another node? Is this a good heuristic?

% estimated_cost = ...

end