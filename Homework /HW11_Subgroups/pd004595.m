function decision = pd004595(p1_hist,p2_hist)

    p2_hist(isnan(p2_hist))=[]; % clear empty indices

    % Begin by cooporating
    if isempty(p2_hist)
        decision = 1;
        
    % Tit-for-tat
    elseif length(p2_hist)>1 & length(p2_hist)<250
        decision = p2_hist(end);
        
    % FINAL STRIKE!!!!!!!! 
    else 
        decision = 0;
    end

end