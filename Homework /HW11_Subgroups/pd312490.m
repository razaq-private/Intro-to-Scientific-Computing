function move = pd312490(~,otherPlayerHistory)
    % function will return 1 if other person is generally good 
    % return 0 if other person is generally bad
    if mean(otherPlayerHistory) >= 0.5
        move = 1;
    else
        move = 0;
    end
end
