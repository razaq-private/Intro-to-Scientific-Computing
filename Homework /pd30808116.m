function choice = pd30808116(p1_past, p2_past)
p1_past = p1_past(~isnan(p1_past));    
p2_past = p2_past(~isnan(p2_past));

%first checks if theyre empty and if so just input a zero
    if isempty(p1_past) || isempty(p2_past)
        choice = 0; 
    elseif length(p1_past) == 1 || length(p2_past) == 1
        choice = 0;
    else 
        if p2_past(end) == 1 && p2_past(end-1) == 1
            choice = 1; 
        else
            choice = 0;
        end
    end  
end