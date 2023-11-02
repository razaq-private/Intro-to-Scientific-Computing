function makeBalloon(~)    
    % create graphics handle object describing Red Balloon
    [redBalloon,~,alphaRedBalloon] = imread('redBalloon.png');
    
    % make the background of balloon transparent
    hRedBalloon = imshow(redBalloon);
    hRedBalloon.AlphaData = alphaRedBalloon;
    hRedBalloon.Visible = 'on';

    % change scaling of balloon on axes
    hRedBalloon.XData = [1,.65*hRedBalloon.XData(2)];
    hRedBalloon.YData = [1,.65*hRedBalloon.YData(2)];

    % indicate the starting position of the balloon
    hRedBalloon.XData = hRedBalloon.XData;
    hRedBalloon.YData = hRedBalloon.YData +75;
    hold on
end    