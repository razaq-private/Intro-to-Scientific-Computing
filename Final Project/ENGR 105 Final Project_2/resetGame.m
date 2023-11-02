function resetGame(~,~,h1,t_redBalloons)
    handles = guidata(h1);
   set(resetButton,'Visible','on')
    
   % set everything related to the home page as not visible
   set(startButton,'Visible','on');
   set(helpButton,'Visible','on');
   set(gca, 'visible', 'on');
   set(gcf,'visible','on');
   
end