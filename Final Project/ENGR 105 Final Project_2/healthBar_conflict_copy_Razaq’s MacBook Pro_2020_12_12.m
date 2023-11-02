function [gameStillGoing,damage] = healthBar(h1,damage,gameStillGoing)
    % retrieve the GUI data
    handles = guidata(h1);
    hballoonObj = handles.balloonObj;

    % if the balloon objects reach the end of the map (1412, 515)
    % then update the health bar and stop the game when health runs out
    for i = length(hballoonObj)
        if hballoonObj(i).XData >= 1396 && damage.Position(3) < 500
            damage.Position(3) = damage.Position(3)+1;
        else  
            gameStillGoing = false;
        end    
       
    end
    % save the graphic objects in the GUI data
    guidata(h1,handles);
end
