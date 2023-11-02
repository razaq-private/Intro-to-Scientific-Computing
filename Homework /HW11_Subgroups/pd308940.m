function decision = pd308940(p2_history,p1_history)
    %pd308940 will be player 2 
    
    %check if player 1 has ever been hostile
    if any(p1_history == 0)
        decision = 0;
        
    %check if 249/250 rounds have been played
    elseif length(p2_history(~isnan(p2_history))) == 249
        decision = 0;
        
    else %be a good boy
        decision = 1;
    end
    
end