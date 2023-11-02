function stopTimer(t,~)
    delete(t);
    % display text to indicate that the game is over
    text(700,300,'GAME OVER','FontSize',100,'Color','w','FontWeight','bold',...
       'HorizontalAlignment','center','FontName','Consolas');
end