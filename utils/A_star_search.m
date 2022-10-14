function [sequence, num_nodes_searched] = A_star_search(board, label, end_loc, immovable_locs)

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

while ~isempty(open_set)
    num_nodes_searched = num_nodes_searched + 1;
    % Select the most promising board configuration from the list
    min_f_score = inf;
    for i = 1:length(open_set)
        % Select the node from the set of frontier nodes with the lowest
        % f-score (f-score = cost-to-go + heuristic function of that node)
        new_f_score = f_score(jsonencode(open_set(i).tiles));
        if new_f_score < min_f_score
            min_f_score = new_f_score;
            current = open_set(i);
            current_index = i;
        end
    end

    % Check if we have found the solution
    label_loc = current.find_loc(label);
    if label_loc == end_loc
        if length(board.move_history) > 0
            sequence = [current.move_history(length(board.move_history)+1:end)];
        else
            % if the tile labeled "label" is now at the position "end_loc" then
            % terminate the search, because we have found our solution!
            sequence = [current.move_history(end)]; % reconstruct optimal path
            while isKey(came_from, jsonencode(current.tiles))
                current = came_from(jsonencode(current.tiles));
                if ~isempty(current.move_history)
                    sequence = [current.move_history(end); sequence];
                end
            end
        end
        return;
    end


     % remove the board configuration from the list
    open_set(current_index) = [];

    % generate all board configurations that are reachable from this one
    neighbors = generate_neighbors(current, immovable_locs);

    for i = 1:length(neighbors)
        % for each neighbor of the current board configuration...
        neighbor = neighbors(i);

        % the cost-to-go of the neighbor is the cost-to-go to 'current' + 1
        tentative_gscore = g_score(jsonencode(current.tiles)) + 1;

        if ~isKey(g_score, jsonencode(neighbor.tiles))
            % if the neighbor score doesn't already exist, then we must
            % have never seen this node before, so set it's cost-to-go as
            % +infinity (by default)
            g_score(jsonencode(neighbor.tiles)) = inf;
        end

        if tentative_gscore < g_score(jsonencode(neighbor.tiles))
            % if the cost-to-go via this route is better than any other
            % route, save this new path
            came_from(jsonencode(neighbor.tiles)) = current;
            g_score(jsonencode(neighbor.tiles)) = tentative_gscore;
            f_score(jsonencode(neighbor.tiles)) = tentative_gscore + h(neighbor);
            
            neighbor_in_open_set = false;
            for j = 1:length(open_set)
                % iterate through the open_set to determine if we already
                % have this board configuration in the set
                if open_set(j) == neighbor
                    neighbor_in_open_set = true;
                    break;
                end
            end

            if ~neighbor_in_open_set
                % if the current neighbor isn't already in the open-set,
                % then add it back, so we can investigate it's children
                % again and update them, since we found a better path to
                % their parent
                open_set = [open_set; neighbor];
            end
        end
    end

    num_nodes_searched = num_nodes_searched + 1;
end

end