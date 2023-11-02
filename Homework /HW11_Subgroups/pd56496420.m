function choice = pd56496420(myHist, theirHist)
    %Takes in two inputs, both players' history
    %Returns one output, in this case a strategy that is 'nice' 
    %yet not naiive. Described in detail above. 
    
    % Co-operate to start
    if nnz(theirHist == 0) < 2
        choice = 1;
    % They are suspicious
    else
        %Cooperated last five moves
        if (length(theirHist) >= 5 && nnz(theirHist(end-5+1:end) == 0) == 0)
            choice = 1;
        else 
            choice = 0; 
        end
    end
end