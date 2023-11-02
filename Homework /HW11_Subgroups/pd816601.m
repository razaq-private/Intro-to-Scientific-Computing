function myOut= pd816601(p,k)
    %If the other player's previous move was hostile, my play will turn hostile
    %for only the next turn
    if k==0
        myOut=0;
    else 
        myOut=1;
    end
end