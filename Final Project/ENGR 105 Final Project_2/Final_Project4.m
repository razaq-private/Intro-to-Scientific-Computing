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

% get the size of the screen and make the axes of the balloons this size
ss = get(0,'ScreenSize');
xlim([0,ss(3)+150])
ylim([0,ss(4)])

% make two red balloons
for k = 1:2
    hold on
    % make the background of balloon transparent
    hRedBalloon(k) = imshow(redBalloon);
    hRedBalloon(k).AlphaData = alphaRedBalloon;
    hRedBalloon(k).Visible = 'on';

    % change scaling of balloon on axes
    hRedBalloon(k).XData = [1,.65*hRedBalloon(k).XData(2)];
    hRedBalloon(k).YData = [1,.65*hRedBalloon(k).YData(2)];

    % indicate the starting position of the balloon
    hRedBalloon(k).XData = hRedBalloon(k).XData;
    hRedBalloon(k).YData = hRedBalloon(k).YData +75;
    
end
hold off

