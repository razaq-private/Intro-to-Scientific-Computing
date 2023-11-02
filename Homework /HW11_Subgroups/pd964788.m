function out = pd964788(p1Hist, p2Hist)
    %x vector of other players past plays without Nan preallocations so we can
    %use logicals
    x = p2Hist(~isnan(p2Hist));
    %Takes probability of playing 1 (cooperating)
    y = sum(x)./(length(x));
    %If first turn or probability is even between cooperation and hostility
    if isempty(x)|| y ==0.5
        %Plays arbitrarily
        out = randi(2)-1;
        %Otherwise output 1 when y>.5 and 0 when y<.5
    else
        out = (y>=0.5);
    end
end 