function [cooperation] = pd985662(~,hist)
    if(isempty(hist))
        cooperation = 0;
        return
    elseif(length(hist) == 1)
        cooperation = 1;
        return
    end
    
    cooperation = hist(end);
end
