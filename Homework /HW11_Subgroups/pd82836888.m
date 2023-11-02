function out = pd82836888(p1_hist,p2_hist)
    d = p1_hist(p1_hist>=0); %Creating a new vector that eliminates the NaN's, so that i may sum it to see how many times  my parttner has been good 
    if sum(d)>=20  %if theyve been good at least 20 times, be bad
        out = 0;
    else
        out = 1; %otherwise be good
    end
end