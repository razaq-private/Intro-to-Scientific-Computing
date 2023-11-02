
function out = pd075723(myDecisions, otherDecisions)
%maybe: if more than 50% of all moves are betrayal, choose 0 (betray)

    if length(otherDecisions) < 10
        out = 1; %start out cooperating for first few moves
    else
        %get number of betrayals from other person so far
        numBetrayed = length(otherDecisions(otherDecisions == 0));
        
        %0 if 50% or more of other's moves are 0, 1 otherwise
        out = numBetrayed < (0.5*length(otherDecisions));    
    end

end
