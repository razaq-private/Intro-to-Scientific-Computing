function out = pd308321(h_1,h_2)
    %start by being hostile until the other player is hostile
    if all(h_2)
        out=0;
    %once the other player acts hostile, act randomly
    else
        out=randi([0 1]);
    end
    
end

