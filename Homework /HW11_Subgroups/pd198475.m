function out = pd198475(p1_h,p2_h)

    n=7;%number of hostile interations until forgiving.
    if isempty(p1_h)%first interaction is always coop.
        out = 1;%good
        return


    elseif length(p1_h)>=n%forgiveness 
        if all(~p1_h(end-(n-1):end))%if last n terms(in this case 7)of p1_h are 0(hostile) give out a 1(coop).
            out = 1;%good
            return
        end

    end

    if p2_h(end)==0||p1_h(end)==0 %If the previous oponent's interaction was hostile or my last interaction was hostile, be hostile.
        out = 0;%bad  
        return
    end

    out = 1;%good

end