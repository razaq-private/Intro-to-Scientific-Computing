function outputMine=pd207729(p1_hist,p2_hist)
    L=250;
    if L<248
        history1=p1_hist(~isnan(p1_hist));
        a=history1(end);
        b=history1(end-1);
        c=history1(end-2);
        if a+b+c==3
            outputMine=1;
        elseif a+b+c==0
            outputMine=0;
        elseif a+b+c==2
            outputMine=1;
        elseif a+b+c==1
            outputMine=0;
        end
    else 
        outputMine=1;
        %because i'm a nice person
    end
    L=L-1;
end