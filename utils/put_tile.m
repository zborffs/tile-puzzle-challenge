function board = put_tile(board, label, dest_loc, immovable_locs)
%PUT_TILE constructs the sequence of moves necessary to move the tile
%labeled "label" to the destination location "dest_loc" subject to the
%constraint that we may not move any tiles which are on locations which are
%in the set "immovable_locs". Then it returns an updated version of the
%'board' argument which has made the sequence of moves.

% Step 0: Check to see if we have already solved the problem
label_loc = board.find_loc(label);
if label_loc == dest_loc
    return;
end

% Step 1: Use A*-search to construct a sequence of moves 
% M={'up', 'down', 'left', 'right}, which will move the tile labeled
% "label" and move it to the location "dest_loc"
[sequence, num_nodes_searched] = A_star_search(board, label, dest_loc, immovable_locs);

% Step 2: Make all the moves returned by the A* search
for i = 1:length(sequence)
    board = board.make_move(sequence(i));
end

board.num_nodes_searched = board.num_nodes_searched + num_nodes_searched;

end