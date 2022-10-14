classdef Board
    %BOARD class that maintains data related to board dimensions and the
    %location of different tiles on the board.

    properties
        num_rows
        num_cols
        tiles
        blank_tile % blank is number '9'

        move_history
        num_nodes_searched
    end

    methods
        function obj = Board(dimension)
            obj.num_rows = int32(dimension);
            obj.num_cols = int32(dimension);
            obj.tiles = reshape(int32(1:dimension * dimension), dimension, dimension)';
            obj.blank_tile = Node(dimension,dimension); % location of the 'blank' you get to slide around
            obj.num_nodes_searched = 0;
        end

        function is_solved = is_solved(obj)
            is_solved = true;
            for i = 1:length(obj.num_rows)
                for j = 1:length(obj.num_cols)
                    if obj.tiles(i,j) ~= (i-1)*obj.num_cols + j
                        is_solved = false;
                        return;
                    end
                end
            end
        end

        function obj = scramble(obj, seed)
            %SCRAMBLE randomizes the board by making random moves
            %   To replicate the same random board, pass in a random seed
            %   for the random number generator.

            rng(seed);
            num_random_moves = 1000;
            for i = 1:num_random_moves
                r = rand; % generate a random number
                if r < 0.25
                    % if the random number is in [0,0.25), then move up
                    obj = obj.make_move(Move.up);
                elseif r < 0.5
                    % if the random number is in [0.25,0.5), then move down
                    obj = obj.make_move(Move.down);
                elseif r < 0.75
                    % if the random number is in [0.5,0.75), then move left
                    obj = obj.make_move(Move.left);
                else
                    % if the random number is in [0.75,1.0), then move
                    % right
                    obj = obj.make_move(Move.right);
                end
            end

            obj.move_history = [];
        end

        function label_loc = find_loc(obj, label)
            %FIND_LOC finds the location (i.e. the node) of the tile
            %labelled 'label
            br = false;
            label_loc = [];
            for i = 1:obj.num_rows
                for j = 1:obj.num_cols
                    if obj.tiles(i,j) == label
                        % for every element making up the board, check if the label of
                        % the current element we are inspecting (board.tiles(i,j)) is
                        % equal to the label of the "label" we want to move.
                        label_loc = Node(i,j);
                        br = true;
                        break; % break out of double for-loop for efficiency
                    end
                end
            
                if br
                    break;
                end
            end
        end

        function obj = make_move(obj, move)
            assert(isa(move, 'Move'))

            if move == Move.up && obj.blank_tile.row ~= obj.num_rows
                % swap blank location and the element below 'blank'
                temp = obj.tiles(obj.blank_tile.row + 1, obj.blank_tile.col);
                obj.tiles(obj.blank_tile.row + 1, obj.blank_tile.col) = obj.tiles(obj.blank_tile.row, obj.blank_tile.col);
                obj.tiles(obj.blank_tile.row, obj.blank_tile.col) = temp;

                % move up if we aren't already at the bottom
                obj.blank_tile.row = obj.blank_tile.row + 1;
                obj.move_history = [obj.move_history; Move.up];

            elseif move == Move.down && obj.blank_tile.row ~= 1
                % swap blank location and the element below 'blank'
                temp = obj.tiles(obj.blank_tile.row - 1, obj.blank_tile.col);
                obj.tiles(obj.blank_tile.row - 1, obj.blank_tile.col) = obj.tiles(obj.blank_tile.row, obj.blank_tile.col);
                obj.tiles(obj.blank_tile.row, obj.blank_tile.col) = temp;

                % move down if we aren't already at the top
                obj.blank_tile.row = obj.blank_tile.row - 1;
                obj.move_history = [obj.move_history; Move.down];

            elseif move == Move.left && obj.blank_tile.col ~= obj.num_cols
                % swap blank location and the element below 'blank'
                temp = obj.tiles(obj.blank_tile.row, obj.blank_tile.col + 1);
                obj.tiles(obj.blank_tile.row, obj.blank_tile.col + 1) = obj.tiles(obj.blank_tile.row, obj.blank_tile.col);
                obj.tiles(obj.blank_tile.row, obj.blank_tile.col) = temp;

                % move down if we aren't already at the top
                obj.blank_tile.col = obj.blank_tile.col + 1;
                obj.move_history = [obj.move_history; Move.left];

            elseif move == Move.right && obj.blank_tile.col ~= 1
                % swap blank location and the element below 'blank'
                temp = obj.tiles(obj.blank_tile.row, obj.blank_tile.col - 1);
                obj.tiles(obj.blank_tile.row, obj.blank_tile.col - 1) = obj.tiles(obj.blank_tile.row, obj.blank_tile.col);
                obj.tiles(obj.blank_tile.row, obj.blank_tile.col) = temp;

                % move down if we aren't already at the top
                obj.blank_tile.col = obj.blank_tile.col - 1;
                obj.move_history = [obj.move_history; Move.right];

            end

        end

        function obj = unmake_move(obj)
            last_move = obj.move_history(end);
            obj.move_history(end) = [];

            if last_move == Move.up
                obj.make_move(Move.down);
            elseif last_move == Move.down
                obj.make_move(Move.up);
            elseif last_move == Move.left
                obj.make_move(Move.right);
            else % last_move == Move.right
                obj.make_move(Move.left);
            end
        end

        function is_on_board = is_tile_on_board(obj, location)
            %IS_TILE_ON_BOARD returns whether a given tile location
            %"location" is within the bounds of the board
            assert(isa(location, 'Node'), "must be of type 'Node'");
            is_on_board = location.row >= 1 && ...
                location.row <= obj.num_rows && ...
                location.col >= 1 && ...
                location.col <= obj.num_cols;
        end

        function equal = eq(obj1, obj2)
            equal = obj1.num_rows == obj2.num_rows && ...
                obj1.num_cols == obj2.num_cols &&...
                all(all(obj1.tiles == obj2.tiles));
        end
    end
end