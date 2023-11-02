function balloonObj = makeBalloon(~,~)    
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
end    