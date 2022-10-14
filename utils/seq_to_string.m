function seq_str = seq_to_string(sequence)
%SEQ_TO_STRING constructs a string representation of a given sequence
%   iterates through the sequence adding a 'u' for 'up' moves, 'd' for
%   'down' moves, 'r' for 'right' moves, and 'l' for 'left' moves

seq_str = "[";
for i = 1:length(sequence)
    if sequence(i) == Move.up
        seq_str = seq_str + " u ";
    elseif sequence(i) == Move.down
        seq_str = seq_str + " d ";
    elseif sequence(i) == Move.left
        seq_str = seq_str + " l ";
    elseif sequence(i) == Move.right
        seq_str = seq_str + " r ";
    end
end
seq_str = seq_str + "]";

end