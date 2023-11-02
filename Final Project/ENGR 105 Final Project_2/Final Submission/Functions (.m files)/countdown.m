function countdown(~)
    % countdown for the user before the game starts
    pause(1);
    textString = ["3","2","1","Start!"];
    for i = 1:length(textString)
        % create text
        i = text(700,300,textString(i),'FontSize',100,'Color','w','FontWeight','bold',...
            'HorizontalAlignment','center','FontName','Consolas');
        % display text for one second
        pause(1);
        % delete the text
        delete(i);
        % pause before repeating (creates a blink effect)
        pause(0.5);
    end
end