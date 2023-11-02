function [out] = pd37957805(hist,histO)
    ratio = sum(histO)/length(histO);
    if ratio < 0.8
        if histO(end) == 1 % the other player played hostile, but began playing coop
            out = 1;
        else
            out = 0; % hostile player continues to be hostile 
        end
    else 
        out = 1; % otherwise coop
    end
end