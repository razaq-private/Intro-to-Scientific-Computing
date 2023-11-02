function out = pd889454(p1_hist,p2_hist)
    % Remove all "not a number" terms from history vector    
    p2_hist(isnan(p2_hist)) = [];
    
    % On the first round, always defect
    if isempty(p1_hist)
        out = 0;
    
    % Tit for tat in the middle. If other player previously cooperated,
    % cooperate. If they previously defected, also defect next round. 
    elseif p2_hist(end) == 1
        out = 1;
    else
        out = 0;
    end   
    
    % On the last round, always defect
    if length(p1_hist) == 249
        out = 0;        
    end
    
end