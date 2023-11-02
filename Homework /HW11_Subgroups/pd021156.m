function output = pd021156(p1_hist,p2_hist)
%In the first round, I will always cooperate, after that I will do whatever
%my opponent did the previous round

    %first round cooperate
    if(isempty(p2_hist))
        output = 1;
    
    %After first round play opponent's previous move
    else
        output = p2_hist(end);
    end
end

