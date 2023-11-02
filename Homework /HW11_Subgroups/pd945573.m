function output= pd945573(~, p2_hist)
    if p2_hist ==0 %If the other player always acts hositle, act hositle so you can at least tie
        output=0;
    else %Otherwise act randomly, in order to beat good and arbitray person
        output= randi(2,1)-1;
    end
end