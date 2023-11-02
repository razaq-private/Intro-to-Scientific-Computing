function move = pd624725(~,other_hist)
%cooperate first round; after that, do what opponent did on previous move

    %if first round, cooperate 
    if isempty(other_hist)
        move = 1 ; 
        
    %else do what opponent did previous move 
    else
        move = other_hist(end) ; 
    end  
end