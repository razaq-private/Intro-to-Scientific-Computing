function f5 = pd745463(p1_hist,p2_hist)
% I would cooperate until the other player acted hostile or until the  
%  last turn, whichever comes first. If they turn me in, I would act hostile until 
% they've cooperated at least 5 times in the previous 10 turns, proving that they're (somewhat) worthy of my decency. 
%I chose the last turn so that way they cannot fight back afterwards.   

    p1 = p1_hist(~isnan(p1_hist));

    f5 = 1; % cooperate as default

    if any(p1) == 0 % once they turn on me, act hostile
        f5 = 0;

    elseif sum(p1(end-9:end)) >= 5 % if they cooperated at least 5 times in the previous 10 turns, cooperate
        f5 = 1;

    elseif p1_hist(249)==0 || p1_hist(249)==1 % at the last turn, act hostile
        f5 = 0;

    end
 
 end