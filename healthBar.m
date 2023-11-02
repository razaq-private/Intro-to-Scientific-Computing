function [gameStillGoing,damage,numActiveBalloons] = healthBar(h1,damage,numActiveBalloons,gameStillGoing)
    % retrieve the GUI data
    handles = guidata(h1);
    hballoonObj = handles.balloonObj;

    % if the balloon objects reach the end of the map
    % then update the health bar and stop the game when health runs out
    for i = numActiveBalloons(numActiveBalloons~=0)
        % when the balloon reaches the end, the damage position increases
        % and decrease the number of active balloons
        if hballoonObj(i).XData >= 1380
            damage.Position(3) = damage.Position(3)+50;
            numActiveBalloons(i) = 0;
        % when all the health is gone, the game stops
        elseif damage.Position(3) == 500
            gameStillGoing = false;
        end          
    end
    
    numActiveBalloons = numActiveBalloons;
    % save the graphic objects in the GUI data
    guidata(h1,handles);
end
