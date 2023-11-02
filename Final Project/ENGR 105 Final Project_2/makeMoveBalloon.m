% make the balloon move along the path (manually)
function makeMoveBalloon(~,~)
    % create graphics handle object describing Red Balloon
    [redBalloon,~,alphaRedBalloon] = imread('redBalloon.png');
    
    % make the background of balloon transparent
    balloonObj = imshow(redBalloon)
    balloonObj.AlphaData = alphaRedBalloon;
    balloonObj.Visible = 'on';

    % change scaling of balloon on axes
    balloonObj.XData = [1,0.5*balloonObj.XData(2)];
    balloonObj.YData = [1,0.5*balloonObj.YData(2)];

    % indicate the starting position of the balloon
    balloonObj.XData = 1;
    balloonObj.YData = 55;
    
    % make the axes of the balloons this size
    xlim([0,1430])
    ylim([0,720])
    
    % wait two seconds before moving the balloon
    pause(2)
    
    for i = 1:67
        balloonObj.XData = balloonObj.XData + 5;
        pause (0.1)
    end
    for j = 1:24
        balloonObj.YData = balloonObj.YData + 5;
        pause (0.1)
    end  
    for k = 1:45
        balloonObj.XData = balloonObj.XData + 5;
        pause (0.1)
    end  
    for j = 1:23
        balloonObj.YData = balloonObj.YData - 5;
        pause (0.1)
    end  
    for k = 1:52
        balloonObj.XData = balloonObj.XData + 5;
        pause (0.1)
    end  
    for j = 1:50
        balloonObj.YData = balloonObj.YData + 5;
        pause (0.1)
    end  
    for k = 1:49
        balloonObj.XData = balloonObj.XData - 5;
        pause (0.1)
    end  
    for j = 1:52
        balloonObj.YData = balloonObj.YData + 5;
        pause (0.1)
    end  
    for k = 1:52
        balloonObj.XData = balloonObj.XData + 5;
        pause (0.1)
    end  
    for j = 1:24
        balloonObj.YData = balloonObj.YData - 5;
        pause (0.1)
    end  
    for k = 1:45
        balloonObj.XData = balloonObj.XData + 5;
        pause (0.1)
    end  
    for j = 1:25
        balloonObj.YData = balloonObj.YData + 5;
        pause (0.1)
    end 
    for k = 1:70
        balloonObj.XData = balloonObj.XData + 5;
        pause (0.1)
    end 
    delete(balloonObj);
end