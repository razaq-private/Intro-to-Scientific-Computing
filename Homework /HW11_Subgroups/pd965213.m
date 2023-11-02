function out = pd965213(self, other)
    % if other is empty; that is, it's the first turn, then we cooperate
    if size(other, 2) == 0
        out = 1;
    else
        %otherwise, we copy whatever the other person did last round
        out = other(end);
    end
end

