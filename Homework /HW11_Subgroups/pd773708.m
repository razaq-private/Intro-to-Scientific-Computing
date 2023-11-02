function output = pd773708(myMove,theirMove)
    theirMove(1)=1; % initial conditions 
    myMove(1)=1; % allow if statements to run for the first move
    % if conditions met, output 0
    if (theirMove(end)==1 && myMove(end)==1) || (theirMove(end)==1 ...
            && myMove(end)==0) || (theirMove(end)==0 && myMove(end)==1) 
        output = 0;
    % if conditions met, output 1
    elseif theirMove(end)==0 && myMove(end)==0
        output = 1;
    end
end