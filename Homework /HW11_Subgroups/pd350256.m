function out = pd350256(a,b)
%This function takes the average of player 1's actions and uses them to
%decide whether or not to be hostile. 
    
    % y is the the number of values in the history function
    x = ~isnan(a);
    y = sum(x);
    
    
    if y == 0 || isnan(y)
        % if there is no history automatically be hostile
        out = 0;
    else
        % Take same action as average of other player's actions (i.e if
        % player 1 is mostly good then player 2 will cooperate)
        decide = (sum(a,'omitnan'))/ y;
        out = round(decide);
    end
   
end
