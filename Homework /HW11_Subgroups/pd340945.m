%Function that will output 1 unless the opponent's previous move is 0,
%which then will output 0
function decision = pd340945(selfPrevMove, oppPrevMove)
    if oppPrevMove == 0
        decision = 0;
    else 
        decision = 1;
    end
    
end