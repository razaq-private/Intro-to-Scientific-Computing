function [out] = pd793431(hist1,hist2)
    numTurns = 250;
    for k = 1:numTurns - 1
        out = 1;
    end
    for k = numTurns - 1:numTurns
        out = 0;
    end
end
