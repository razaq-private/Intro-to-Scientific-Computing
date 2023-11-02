function out = pd793245(x,y)
    % Personal strategy for prisoner's dilemma
    
    % first move is zero
    if isempty(x)
        out = 0;
    
    % if other player keeps playing 1, return 0; 
    % otherwise, return their previous move    
    else
        out = (prod(y) ~= 1)*y(end) + (prod(y) == 1)*isempty(y);
    end
end