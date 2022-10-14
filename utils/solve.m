function [soln, num_nodes_searched] = solve(board)
%SOLVE solves the puzzle
%   Detailed explanation goes here

n = board.num_rows;
m = board.num_cols;
solved_locs = containers.Map;
a = @(x,y) y + (x-1) * m;

% initialize solution
soln = [];

i = 1; % keeps track of row we are on
j = 1; % keeps track of column we are on

while i <= n-1 && j <= m-1
    if mod(j, 2) == 1 % lets complete a column (row-wise solve)
        i_bar = i;
        while i_bar <= n - 2
%             board.tiles
            board = put_tile(board, a(i,j), Node(i_bar, j), solved_locs);
            solved_locs(jsonencode(Node(i_bar, j))) = 0; % add the solved location to the dict
            i_bar = i_bar + 1;
        end

        board = put_tile(board, a(n,j), Node(n-1,j), solved_locs);
        if board.blank_tile == Node(n,j)
            board = board.make_move(Move.left);
        end

        a_n_m1_j_loc = board.find_loc(a(n-1,j));
        
        if a_n_m1_j_loc == Node(n, j)
            % if the node that tile "a(n-1,j)" happens to be "a(n,j)", then
            % move it off 
            board = put_tile(board, a(n,m), Node(n, j+1), solved_locs); % put blank square next to top
            board = board.make_move(Move.right);
            board = board.make_move(Move.down);
            board = board.make_move(Move.left);
            board = board.make_move(Move.left);
            board = board.make_move(Move.up);
            board = board.make_move(Move.right);
            board = board.make_move(Move.down);
            board = board.make_move(Move.right);
            board = board.make_move(Move.up);
        end

        solved_locs(jsonencode(Node(n-1,j))) = 0;
        board = put_tile(board, a(n-1,j), Node(n-1,j+1), solved_locs); % put blank square next to top
        solved_locs(jsonencode(Node(n-1,j+1))) = 0;
        board = put_tile(board, a(n,m), Node(n,j), solved_locs); % put blank square next to top
        solved_locs = remove(solved_locs, jsonencode(Node(n-1,j)));
        solved_locs = remove(solved_locs, jsonencode(Node(n-1,j+1)));
        board = board.make_move(Move.down);
        board = board.make_move(Move.left);

        solved_locs(jsonencode(Node(n-1, j))) = 0;
        solved_locs(jsonencode(Node(n, j))) = 0;
        j = j + 1;
        
    else % j % 2 == 0
        j_bar = j;
        while j_bar <= m - 2
            %test on 4x4
            board = put_tile(board, a(i,j_bar), Node(i, j_bar), solved_locs);
            solved_locs(jsonencode(Node(i, j_bar))) = 0; % add the solved location to the dict
            j_bar = j_bar + 1;
        end

        board = put_tile(board, a(i,m), Node(i,m-1), solved_locs);
        if board.blank_tile == Node(i,m)
            board = board.make_move(Move.up);
        end

        a_i_m_m1_loc = board.find_loc(a(i,m-1));

        if a_i_m_m1_loc == Node(i, m)
            board = put_tile(board, a(n,m), Node(i+1, m), solved_locs); % put blank square next to top
            board = board.make_move(Move.down);
            board = board.make_move(Move.right);
            board = board.make_move(Move.up);
            board = board.make_move(Move.up);
            board = board.make_move(Move.left);
            board = board.make_move(Move.down);
            board = board.make_move(Move.right);
            board = board.make_move(Move.down);
            board = board.make_move(Move.left);
        end

        solved_locs(jsonencode(Node(i,m-1))) = 0;
        board = put_tile(board, a(i,m-1), Node(i+1,m-1), solved_locs); % put blank square next to top
        solved_locs(jsonencode(Node(i+1,m-1))) = 0;
        board = put_tile(board, a(n,m), Node(i,m), solved_locs); % put blank square next to top
        solved_locs = remove(solved_locs, jsonencode(Node(i+1,m-1)));
        solved_locs = remove(solved_locs, jsonencode(Node(i,m-1)));
        board = board.make_move(Move.right);
        board = board.make_move(Move.up);

        solved_locs(jsonencode(Node(i, m-1))) = 0;
        solved_locs(jsonencode(Node(i, m))) = 0;

        i = i + 1;
    end
end

board = put_tile(board, a(n,m), Node(n,m), solved_locs);

while ~board.is_solved()
    board = board.make_move(Move.down);
    board = board.make_move(Move.right);
    board = board.make_move(Move.up);
    board = board.make_move(Move.left);
end
soln = board.move_history;
num_nodes_searched = board.num_nodes_searched;


end