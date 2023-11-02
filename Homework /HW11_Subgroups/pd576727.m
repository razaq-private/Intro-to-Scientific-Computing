function f = pd576727(p1history,p2history)
    %my strategy is essentially to behave exactly in the way the other
    %person does for all 250 turns
    %I'm using that "average" strategy I had for massiveRetaliation above
    if mean(p2history) >= 0.5; %close to 1
        f = 1;
    else
        f = 0;
    end
end