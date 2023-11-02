function startGame_1(h1,~,axes,startButton,helpButton)
    % retrieve the GUI data
    handles = guidata(h1);
    handles.homePage = 0;
    homePage = handles.homePage;
    % set everything related to the home page as not visible
    set(startButton,'Visible','off');
    set(helpButton,'Visible','off');
    set(gca, 'visible', 'off');
    
    guidata(h1,handles);
end
