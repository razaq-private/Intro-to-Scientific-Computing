function moveBalloon6(~,~,h1,balloonVec,prevBalloons,bananaScore,pointScore,damage)
    % retrieve the GUI data
    handles = guidata(h1);
    balloonObj = handles.balloonObj;
    balloonStep = handles.balloonStep;
    startPos = handles.startPos;
    bullet = handles.rectPos;

    % vector that encodes the specific time steps for each stretch of path
    % time steps change for different speeds, denoted in different rows
    timeSteps = [67,90,136,160,212,260,310,365,415,440,490,515,580];
    
    % go through each of the balloons to increment them by one timestep
    for i = balloonVec
        
        % make the start position true if it hits the initial start pos
        % indicates that the balloon started on the path
        if balloonObj(i+prevBalloons).XData >= 0
            startPos(i+prevBalloons) = 1;
        end
          
        % increment the step by 1 only after it starts 
        if startPos(i+prevBalloons) == 1
            balloonStep(i+prevBalloons) = balloonStep(i+prevBalloons) + 1;
        end
        
        % hard code of the steps that the balloons should be moving
        % to follow the path
        
        % make the balloon move right if it hasn't hit the start pos yet
        if balloonStep(i+prevBalloons) == 0
            balloonObj(i+prevBalloons).XData = balloonObj(i+prevBalloons).XData+5;
        % path 1    
        elseif balloonStep(i+prevBalloons) < timeSteps(1) && balloonStep(i+prevBalloons) ~=0
            balloonObj(i+prevBalloons).XData = balloonObj(i+prevBalloons).XData+5;
        % path 2
        elseif balloonStep(i+prevBalloons) >= timeSteps(1) && balloonStep(i+prevBalloons) < timeSteps(2)  
            balloonObj(i+prevBalloons).YData = balloonObj(i+prevBalloons).YData+5;
        % path 3
        elseif balloonStep(i+prevBalloons) >= timeSteps(2) && balloonStep(i+prevBalloons) < timeSteps(3)
            balloonObj(i+prevBalloons).XData = balloonObj(i+prevBalloons).XData+5;
        % path 4
        elseif balloonStep(i+prevBalloons) >= timeSteps(3) && balloonStep(i+prevBalloons) < timeSteps(4) 
            balloonObj(i+prevBalloons).YData = balloonObj(i+prevBalloons).YData-5;
        % path 5
        elseif balloonStep(i+prevBalloons) >= timeSteps(4) && balloonStep(i+prevBalloons) < timeSteps(5)
            balloonObj(i+prevBalloons).XData = balloonObj(i+prevBalloons).XData+5;
        % path 6
        elseif balloonStep(i+prevBalloons) >= timeSteps(5) && balloonStep(i+prevBalloons) < timeSteps(6)
            balloonObj(i+prevBalloons).YData = balloonObj(i+prevBalloons).YData+5;    
        % path 7
        elseif balloonStep(i+prevBalloons) >= timeSteps(6) && balloonStep(i+prevBalloons) < timeSteps(7)
            balloonObj(i+prevBalloons).XData = balloonObj(i+prevBalloons).XData-5; 
        % path 8
        elseif balloonStep(i+prevBalloons) >= timeSteps(7) && balloonStep(i+prevBalloons) < timeSteps(8)
            balloonObj(i+prevBalloons).YData = balloonObj(i+prevBalloons).YData+5;              
        % path 9
        elseif balloonStep(i+prevBalloons) >= timeSteps(8) && balloonStep(i+prevBalloons) < timeSteps(9)
            balloonObj(i+prevBalloons).XData = balloonObj(i+prevBalloons).XData+5;
        % path 10
        elseif balloonStep(i+prevBalloons) >= timeSteps(9) && balloonStep(i+prevBalloons) < timeSteps(10)
            balloonObj(i+prevBalloons).YData = balloonObj(i+prevBalloons).YData-5;
        % path 11
        elseif balloonStep(i+prevBalloons) >= timeSteps(10) && balloonStep(i+prevBalloons) < timeSteps(11)
            balloonObj(i+prevBalloons).XData = balloonObj(i+prevBalloons).XData+5;
        % path 12
        elseif balloonStep(i+prevBalloons) >= timeSteps(11) && balloonStep(i+prevBalloons) < timeSteps(12)
            balloonObj(i+prevBalloons).YData = balloonObj(i+prevBalloons).YData+5;
        % path 13
        elseif balloonStep(i+prevBalloons) >= timeSteps(12) && balloonStep(i+prevBalloons) < timeSteps(13)
            balloonObj(i+prevBalloons).XData = balloonObj(i+prevBalloons).XData+5; 
                
        % when the balloon hits the end of the path, then make the balloon
        % disappear and clear associated variables so that it doesn't
        % update
        else
            % make the balloons not visible and keep track of the step it
            % is on
            
            % but make sure that the balloons are visible and not
            % previously popped
            if balloonObj(i+prevBalloons).Visible == 'on';
                balloonObj(i+prevBalloons).Visible = 'off';;
                startPos(i+prevBalloons) = 0;
                balloonStep(i+prevBalloons) = NaN;
                % increment the damage bar if the balloon reaches the end
                damage.Position(3) = damage.Position(3) +5;
            end
        end
        
%         if ~isempty(bullet)
%             a = bullet(1)
%             b = bullet(2)
%         end
%         
%         c = balloonObj(i+prevBalloons).XData(1)
%         e = balloonObj(i+prevBalloons).YData(1)
   
         % check to see if the balloon and bullet are in the same vicinity
         if ~isempty(bullet)&&...
              bullet(1) >= balloonObj(i+prevBalloons).XData &&...
              bullet(1) <= balloonObj(i+prevBalloons).XData + 35 &&...
              bullet(2) <= balloonObj(i+prevBalloons).YData &&...
              bullet(2) >= balloonObj(i+prevBalloons).YData - 63              
          
              % make the balloon not visible
              balloonObj(i+prevBalloons).Visible = 'off';
              % increase the score if the player hits a balloon
              pointCounter(h1,pointScore);
         elseif ~isempty(bullet)&&...
                 bullet(1)+bullet(3) >= balloonObj(i+prevBalloons).XData &&...
                 bullet(1)+bullet(3) <= balloonObj(i+prevBalloons).XData + 35 &&...
                 bullet(2) <= balloonObj(i+prevBalloons).YData &&...
                 bullet(2) >= balloonObj(i+prevBalloons).YData - 63
             % make the balloon not visible
              balloonObj(i+prevBalloons).Visible = 'off';
              % increase the score if the player hits a balloon
              pointCounter(h1,pointScore);
         end
        
        % add bananas to the counter
        bananaCounter(h1,bananaScore);    
        
    end
    
     
    
    % when the damage bar is full, delete the timer - stop moving balloons
    if damage.Position(3) >= 500
        stopTimer;
    end
   
    
    % save the graphic objects in the GUI data
    handles.rectPos = bullet;
    handles.balloonObj = balloonObj;
    handles.balloonStep = balloonStep;
    handles.startPos = startPos;
    guidata(h1,handles)
    
    % function for incrememting the points
    function pointCounter(h1,hedit)
        % retrieve the GUI data
        handles = guidata(h1);
        poppedBalloon = false;

        % when a balloon is popped
        if poppedBalloon == true
            handles.points = handles.points + 1;
            % update the bananas textbox with the score
            hedit.String = handles.points;
    end
    
    % save the gui data
    guidata(h1,handles);
    end

    % function for creating more bananas as "currency"
    function bananaCounter(h1,hedit)
        % retrieve the GUI data
        handles = guidata(h1);
        handles.bananas = handles.bananas + 1;

        % only update the text string for whole numbers
        if mod(handles.bananas,10) == 0
            % update the bananas textbox with the score
            hedit.String = handles.bananas;
        end

        % save the gui data
        guidata(h1,handles);
    end

end
