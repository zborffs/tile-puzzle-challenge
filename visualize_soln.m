addpath('utils'); % add the 'utils' folder to the path

% Choose these parameters
dimension = 3; % the dimension of the board (3x3 or 4x4 or ...)
rng_seed = 123; % pick a random number generator (rng) seed

% Don't touch anything after this line
board = Board(dimension); % instantiate Board object
board = board.scramble(seed); % scramble the board according to seed
[soln, ~] = solve(board); % solve the board (this calls your A* algorithm)
animate_soln(board, soln); % animate the solution to the board