function out = pd945983(yours,opponents)
    if length(opponents)<4
        out=1;
    elseif (opponents(end)==0 && opponents(end-1)==0 && opponents(end-2)==0)
        out=0;
    else
        out=1;
    end
end