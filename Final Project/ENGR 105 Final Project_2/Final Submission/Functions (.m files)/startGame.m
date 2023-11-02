function startGame(~,~,h1,axes,startButton,helpButton,t_redBalloons)%,t_blueBalloons,t_greenBalloons)
% I can try to start the timer inside the startGame fucntion in order to make the balloons move
% I can try to put the whole code inside this function so that it runs the
% game
% when resetting, remember to 


   handles = guidata(h1);

   %countdown; 
   % set everything related to the home page as not visible
   %set(h1,'Visible','on')
   set(startButton,'Visible','off');
   set(helpButton,'Visible','off');
   set(gca, 'visible', 'off');
   set(gcf,'visible','off');
   %start the game after the home screen is no longer visible
   countdown;
   start([t_redBalloons]); %,t_blueBalloons,t_greenBalloons])
end
