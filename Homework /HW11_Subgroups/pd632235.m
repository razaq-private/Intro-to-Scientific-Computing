function f5 = pd632235(p1_hist,p2_hist)
    if prod(p1_hist(~isnan(p1_hist))) ==0
       f5 = randi(2) - 1;
       
    else 
        f5 = 1;
    end
end