function [decision] = pd691292(history, otherhistory)
    %takes the average of the other person's strategey to create a
    %percentage of how likely they are to cooperate
    other_predom_strat = sum(otherhistory(~isnan(otherhistory)))/ ... 
    length(otherhistory(~isnan(otherhistory)));
    
    %if the other person is likely to cooperate, I will continue to
    %cooperate
    if other_predom_strat > .5 
        decision = 1;
        
    %else I will not cooperate
    else
        decision = 0;
    end
end

