function output = pd89856909(~,player1) %differnt strategy
     if  length(player1) == 0 %In the first round, cooporate
         output = 1;


     else
         output = player1(length(player1)); %play what the other
         %player played last
     end


end