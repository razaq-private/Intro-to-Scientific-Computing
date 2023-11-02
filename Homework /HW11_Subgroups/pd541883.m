function out = pd541883(p1history, p2history)
    % first take out all of the the NaN
    p1history = p1history(~isnan(p1history));
    p2history = p2history(~isnan(p2history));
    
    % only for the first moves where the vectors are empty, play 0
    if isempty(p1history) || isempty(p2history)
        out = 0;
    % for the second move, play a 1
    elseif length(p1history) == 1 || length(p2history) == 1
        out = 1;
    % for all other moves
    else
        % if the other player has played a 1 last, play a 1
        if p2history(end) == 1
            out = 1;    
        % else play a zero (be hostile)
        else
            out = 0;
        end
    end
    
end