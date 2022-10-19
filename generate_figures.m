addpath('utils'); % add 'utils' folder to the path

dimension_max = 5; % set to whatever the max dimension you want
num_problems = 100; % number of problems to be solved per dimension
solved_all = true; % whether all boards are solved in each dimension

max_nodes_searched = [];
for k = 3:dimension_max % starting from dimension 2 up to "dimension_max"
    num_nodes_searched = []; % count up the number of nodes searched in each board
    for i = 1:num_problems
        b = Board(k); % instantiate the board
        seed = i;
        b = b.scramble(seed); % scramble the board
        [soln, num_nodes_searched_i] = solve(b); % solve the board
        num_nodes_searched = [num_nodes_searched; num_nodes_searched_i]; % record # of searched nodes
    
        for j = 1:length(soln)
            % iterate through the solution
            b = b.make_move(soln(j));
        end
    
        if b.is_solved()
            % verify that the solution actually solves the problem
            fprintf("Solved : %d x %d (seed: %d)\n", b.num_rows, b.num_cols, seed)
        else
            fprintf("Failed : %d x %d (seed: %d)\n", b.num_rows, b.num_cols, seed)
            solved_all = false;
        end
    end

    % Report whether we solved all or failed any...
    if solved_all
        fprintf("PASSED (n=%d)\n", k);
    else
        fprintf("FAILED (n=%d)\n", k);
    end

    histogram(num_nodes_searched); hold on; % generate a histogram of num. nodes searched for each dimension

    % measure the maximum number of nodes it took to solve the all the
    % problems in a given dimension
    max_node_searched = max(num_nodes_searched);
    max_nodes_searched = [max_nodes_searched; max_node_searched];
    disp("Max Number of Nodes Searched (dim=" + num2str(k) + "): " + num2str(max_node_searched));

    % measure the median number of nodes it took to solve the all the
    % problems in a given dimension
    median_node_searched = median(num_nodes_searched);
    disp("Median Number of Nodes Searched (dim=" + num2str(k) + "): " + num2str(median_node_searched));
end

% legend("3x3 board", "4x4 board", "5x5 board")
title("Distribution of Number of Nodes Searched (n=" + num2str(num_problems) + " per sample)");


% graphs the max number of nodes in the batch of 100 it took to solve for
% each dimension
% figure(2); scatter(3:dimension_max, max_nodes_searched, "filled", 'k'); grid on;
% title("Effect of Dimension on Max Number of Searched Nodes")
% xlabel("Board Dimension")
% ylabel("Max Number of Searched Nodes")
