function play = pd58445958(myPrev,theirPrev)

% Rat the person out first, afterwards, don't rat them out unless the they rat you out. 

    % First play is hostile
    if all(isnan(myPrev))
        play = 0;
        
    % If all the other player's plays so far have been cooperative,
    % cooperate
    elseif prod(theirPrev) == 1
        play = 1;
        
    % Otherwise, be hostile
    else
        play = 0;
    end

end