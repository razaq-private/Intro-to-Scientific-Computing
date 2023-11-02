function out5 = pd844602(~,p2)

    % Cooperate in the first play
    out5 = 1;

    if length(p2)==1
        out5 = 1;
    elseif length(p2)==2
        % Cooperates if the other player was not hostile in the last play
        out5 = 1*(p2(end)==1);
    elseif sum(p2==1) >= 0.75*length(p2) && (length(p2)>=5)
        % Become hostile if the other player cooperated 75% of the time and was hostile at least once
        out5 = 1*(all(p2==1));
    elseif sum(p2==0) >= 0.75*length(p2) && (length(p2)>=5)
        % Become hostile if the other player was hostile 75% of the time
        out5= 0;
    elseif length(p2)>2
        % Cooperate if the other player cooperated 3 times in a row.
        out5=1*(p2(end)==1&p2(end-1)==1&p2(end-2)==1);
    end
end