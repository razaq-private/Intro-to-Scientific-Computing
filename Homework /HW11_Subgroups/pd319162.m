function decision = pd319162(p1_hist, p2_hist)
    % Player plays a Tit For Tat strategy
    % p1_hist - player one history
    % p2_hist - player two history
    % decision - player's decision
    
    % if previous decision by other player was to be hostile be hostile
    % otherwise be agreeable
    if ~isempty(p2_hist) && p2_hist(end) == 0
        decision = 0;
    else
        decision = 1;
    end
end