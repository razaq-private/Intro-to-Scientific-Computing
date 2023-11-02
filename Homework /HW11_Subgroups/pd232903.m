function out = pd232903(x,y)
    if ~isempty(x) && y(end)==0
        % If the other player was hostile last time, my player will be hostile this time
        out = 0;
    elseif ~isempty(x) && y(end)==1
        % If the other player was colllaborative last time, my player will
        % be collaorative this time
        out = 1;
    else
        % on the first turn when there is no history, my
        % player will collaborate
        out = 1;
    end
end