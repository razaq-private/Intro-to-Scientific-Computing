function out = pd51858926(myhist,otherhist)
    if length(otherhist) >= 5

        if any(otherhist(end-4:end)) == 1
            out = 0;            
        elseif all(otherhist(end-4:end)) == 0
            out = 0;  
        else
            out = 1;
        end
        
    else
        out = 1;
    end
end

