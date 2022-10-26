addpath('utils'); % add the 'utils' folder to the path

% Update this paramter to test your solution to different board sizes
dimension = 4; % the dimensions of the Board (e.g. 3x3 or 4x4 or ...)

% Don't touch anything beyond this line.
num_problems = 100; % the number of random problems to solve
solved_all = true; % whether all boards are solved
for i = 1:num_problems
    % for every random board

    board = Board(dimension); % instantiate the board object
    rng_seed = i; % set the random number generator (rng) seed to "i"
    board = board.scramble(rng_seed); % scramble the board object according to rng
    [soln, ~] = solve(board); % solve the board (this calls your A* algorithm)

    for j = 1:length(soln)
        % update the Board object by iterating through solutions
        board = board.make_move(soln(j));
    end

    if board.is_solved()
        % if the final Board object after iterating thru solutions is
        % solved, then report "Solved"
        fprintf("Solved : %d x %d (seed: %d)\n", board.num_rows, board.num_cols, rng_seed)
    else
        % if the final Board object after iterating thru solutions is
        % NOT solved, then report "Failed"
        fprintf("Failed : %d x %d (seed: %d)\n", board.num_rows, board.num_cols, rng_seed)
        solved_all = false;
    end
end

% Report whether we solved all or failed any...
if solved_all
    % if we solved all problems, then report "PASSED"
    fprintf("PASSED (n=%d)\n", dimension);
else
    % if we didn't solve any problem, then report "FAILED"
    fprintf("FAILED (n=%d)\n", dimension);
end