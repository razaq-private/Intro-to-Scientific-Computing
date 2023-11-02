close all

% store map image in variable
map_image = imread('bloonsMap.png');

% create axes that are visible
g1 = axes('units','normalized', ...
            'position',[0,0,1,1]);
% stack the axes on the bottom        
uistack(g1,'bottom')

% read and show the image
g2 = imagesc(map_image)
% set the visibility of the axes to invisible
set(g1,'handlevisibility','off', ...
            'visible','on')
% enlarge to the full screen
set(gcf, 'units','normalized','outerposition',[0,0,1,1]);

g1Pos = get(g1,'position');
g3=axes('units','normalized', ...
            'position',[0,0,1,1]);

% create graphics handle object describing Red Balloon
[redBalloon,~,alphaRedBalloon] = imread('redBalloon.png');

% make the background of balloon transparent
hRedBalloon = imshow(redBalloon);
hRedBalloon.AlphaData = alphaRedBalloon;
hRedBalloon.Visible = 'on';

% get the size of the screen and make the axes of the balloons this size
ss = get(0,'ScreenSize');
xlim([0,ss(3)+150])
ylim([0,ss(4)])

% change scaling of balloon on axes
hRedBalloon.XData = [1,.65*hRedBalloon.XData(2)];
hRedBalloon.YData = [1,.65*hRedBalloon.YData(2)];

% indicate the starting position of the balloon
hRedBalloon.XData = hRedBalloon.XData;
hRedBalloon.YData = hRedBalloon.YData +75;

%set up the health bars for the player
boundaryRec = rectangle('Position',[50 19.5 500 10], 'LineWidth', 3);
greenRec = rectangle('Position',[50 19.5 500 10], 'FaceColor', 'green');
redRec = rectangle('Position', [50 19.5 0 10], 'FaceColor', 'red');
% make the balloon move along the path (manually)
for i = 1:67
    hRedBalloon.XData = hRedBalloon.XData + 5;
    if hRedBalloon.XData == 6
        redRec.Position(3) = redRec.Position(3) + 5; 
    end
    pause (0.1)
end
for j = 1:24
    hRedBalloon.YData = hRedBalloon.YData + 5;
    pause (0.1)
end  
for k = 1:45
    hRedBalloon.XData = hRedBalloon.XData + 5;
    pause (0.1)
end  
for j = 1:23
    hRedBalloon.YData = hRedBalloon.YData - 5;
    pause (0.1)
end  
for k = 1:52
    hRedBalloon.XData = hRedBalloon.XData + 5;
    pause (0.1)
end  
for j = 1:50
    hRedBalloon.YData = hRedBalloon.YData + 5;
    pause (0.1)
end  
for k = 1:49
    hRedBalloon.XData = hRedBalloon.XData - 5;
    pause (0.1)
end  
for j = 1:52
    hRedBalloon.YData = hRedBalloon.YData + 5;
    pause (0.1)
end  
for k = 1:52
    hRedBalloon.XData = hRedBalloon.XData + 5;
    pause (0.1)
end  
for j = 1:24
    hRedBalloon.YData = hRedBalloon.YData - 5;
    pause (0.1)
end  
for k = 1:45
    hRedBalloon.XData = hRedBalloon.XData + 5;
    pause (0.1)
end  
for j = 1:25
    hRedBalloon.YData = hRedBalloon.YData + 5;
    pause (0.1)
end 
for k = 1:60
    hRedBalloon.XData = hRedBalloon.XData + 5;
    pause (0.1)
end 