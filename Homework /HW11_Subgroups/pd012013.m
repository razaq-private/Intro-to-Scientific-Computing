function output = pd012013(~,opponentHist)
%my function takes the opponent history as an input and returns a play as
%an output
%My function creates an output by betraying on the first move, and then
%looks at what the opponent does, on average, in retaliation
    %on the first move, betray
    if(length(opponentHist) == 0)
        output = 0;
    end
    %create variables that store p1 zeros (betrayals) and ones
    opponentBetrayals = sum(opponentHist == 0);
    opponentCooperate = sum(opponentHist == 1);
    %if other player betrayals is greater than other player cooperation times 0.5,
    %betray
    if(opponentBetrayals >= 0.5*opponentCooperate)
        output = 0;
    else
        %else, cooperate
        output = 1;
    end
    
end


