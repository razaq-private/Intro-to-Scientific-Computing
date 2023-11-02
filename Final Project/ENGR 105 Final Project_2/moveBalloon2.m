% make the balloon move along the path (manually)
function moveBalloon(balloonObj)
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
end