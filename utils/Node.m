classdef Node
    %NODE object representing a tile in the puzzle.

    properties
        row
        col
    end

    methods
        function obj = Node(row, col)
            obj.row = int32(row);
            obj.col = int32(col);
        end

        function equal = eq(obj1, obj2)
            equal = obj1.row == obj2.row && obj1.col == obj2.col;
        end
    end
end