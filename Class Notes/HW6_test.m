t_95 = [];
%incrament t until t is within the 5 percent 
for k =0.5:1:50 
    t = 0;
    %function that finds the concentration depending on the k value
    C = @(k)5*exp(-(k*t+exp(-t)-1));
    %concentration at the initial time 
    Cint = 5*exp(-(k*0+exp(-0)-1));
    %if the conditon is fufiled, increase t slightly for the values that
    %work
    while C(k) - 0.05*Cint > 10^-6
        %incrament slighly
        t = t + 0.0001;
        C = 5*exp(-(k*t+exp(-t)-1));
    end
    %need to add t to the end
    t_95(end+1) = t;
end