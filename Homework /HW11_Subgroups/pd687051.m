% I am assuming that I will always be player 2 in this scenario
% I am going to try to be tricky and gain an advantage, so if the last 
% move of player 1 was cooperate I am going to be hostile. 
% If they happened to be hostile last time I will cooperate because
% I want them to think I am trying to make peace. This function is
% designed for more rational players you could encounter in the real world.

function out = pd687051(p1_hist,p2_hist)
prevplay = (p1_hist(~isnan(p1_hist)));
    if prevplay == 1
        out = 0;
    else
        out = 1;
                 
    end
end