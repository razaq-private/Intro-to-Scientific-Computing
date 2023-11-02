function [balloonStep,startPos] = moveBalloon(h1,balloonVec,balloonStep,startPos,prevBalloons,order)
    % retrieve the GUI data
    handles = guidata(h1);
    hballoonObj = handles.balloonObj;

    % vector that encodes the specific time steps for each stretch of path
    % time steps change for different speeds, denoted in different rows
    timeSteps = [67,90,136,160,212,260,310,365,415,440,490,515,580];
    timeSteps(2,:) = timeSteps/2;
    
    % vector that encodes the movement increments to encode "speed"
    increment = [5,10];
    
    % go through each of the balloons to increment them by one timestep
    for i = balloonVec
        
        % hard code of the steps that the balloons should be moving
        % to follow the path
        
        % indicate that the game is still going so balloons move
        gameStillGoing = true;
        
        % make the balloon move right if it hasn't hit the start pos yet
        if balloonStep(i) == 0
            hballoonObj(i+prevBalloons).XData = hballoonObj(i+prevBalloons).XData+5;
        % path 1    
        elseif balloonStep(i) < timeSteps(1) && balloonStep(i) ~=0
            hballoonObj(i+prevBalloons).XData = hballoonObj(i+prevBalloons).XData+5;
        % path 2
        elseif balloonStep(i) >= timeSteps(1) && balloonStep(i) < timeSteps(2)  
            hballoonObj(i+prevBalloons).YData = hballoonObj(i+prevBalloons).YData+5;
        % path 3
        elseif balloonStep(i) >= timeSteps(2) && balloonStep(i) < timeSteps(3)
            hballoonObj(i+prevBalloons).XData = hballoonObj(i+prevBalloons).XData+5;
        % path 4
        elseif balloonStep(i) >= timeSteps(3) && balloonStep(i) < timeSteps(4) 
            hballoonObj(i+prevBalloons).YData = hballoonObj(i+prevBalloons).YData-5;
        % path 5
        elseif balloonStep(i) >= timeSteps(4) && balloonStep(i) < timeSteps(5)
            hballoonObj(i+prevBalloons).XData = hballoonObj(i+prevBalloons).XData+5;
        % path 6
        elseif balloonStep(i) >= timeSteps(5) && balloonStep(i) < timeSteps(6)
            hballoonObj(i+prevBalloons).YData = hballoonObj(i+prevBalloons).YData+5;    
        % path 7
        elseif balloonStep(i) >= timeSteps(6) && balloonStep(i) < timeSteps(7)
            hballoonObj(i+prevBalloons).XData = hballoonObj(i+prevBalloons).XData-5; 
        % path 8
        elseif balloonStep(i) >= timeSteps(7) && balloonStep(i) < timeSteps(8)
            hballoonObj(i+prevBalloons).YData = hballoonObj(i+prevBalloons).YData+5;              
        % path 9
        elseif balloonStep(i) >= timeSteps(8) && balloonStep(i) < timeSteps(9)
            hballoonObj(i+prevBalloons).XData = hballoonObj(i+prevBalloons).XData+5;
        % path 10
        elseif balloonStep(i) >= timeSteps(9) && balloonStep(i) < timeSteps(10)
            hballoonObj(i+prevBalloons).YData = hballoonObj(i+prevBalloons).YData-5;
        % path 11
        elseif balloonStep(i) >= timeSteps(10) && balloonStep(i) < timeSteps(11)
            hballoonObj(i+prevBalloons).XData = hballoonObj(i+prevBalloons).XData+5;
        % path 12
        elseif balloonStep(i) >= timeSteps(11) && balloonStep(i) < timeSteps(12)
            hballoonObj(i+prevBalloons).YData = hballoonObj(i+prevBalloons).YData+5;
        % path 13
        elseif balloonStep(i) >= timeSteps(12) && balloonStep(i) < timeSteps(13)
            hballoonObj(i+prevBalloons).XData = hballoonObj(i+prevBalloons).XData+5; 
        
        % when the balloon hits the end of the path, make the balloon
        % disappear and clear associated variables so that it doesn't
        % update
        else
            hballoonObj(i+prevBalloons).Visible = 'off';
            startPos(i) = 0;
            balloonStep(i) = NaN;
        end    
        
        % make the start position true if it hits the initial start pos
        % indicates that the balloon started on the path
        if hballoonObj(i+prevBalloons).XData >= 0
            startPos(i) = 1;
        end
          
        % increment the step by 1 only after it starts 
        if startPos(i) == 1
            balloonStep(i) = balloonStep(i) + 1;
        end
        
    end
    
    % pause
    pause(0.1)
    
    % save the graphic objects in the GUI data
    handles.balloonObj = hballoonObj;
end