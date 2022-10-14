addpath('utils');

dimension = 3;
num_problems = 100;
solved_all = true;

num_nodes_searched = [];
for i = 1:num_problems
    b = Board(dimension);
    seed = i;
    b = b.scramble(seed);
    [soln, num_nodes_searched_i] = solve(b);
    num_nodes_searched = [num_nodes_searched; num_nodes_searched_i];

    for i = 1:length(soln)
        b = b.make_move(soln(i));
    end

    if b.is_solved()
        fprintf("Solved : %d x %d (seed: %d)\n", b.num_rows, b.num_cols, seed)
    else
        fprintf("Failed : %d x %d (seed: %d)\n", b.num_rows, b.num_cols, seed)
        solved_all = false;
    end
end
figure(2); hist(num_nodes_searched); title("Distribution of Number of Nodes Searched on Given Board (n=" + num2str(num_problems) + ")");
median_node_searched = median(num_nodes_searched);


if solved_all
    fprintf("PASSED (n=%d)\n", dimension);
else
    fprintf("FAILED (n=%d)\n", dimension);
end

