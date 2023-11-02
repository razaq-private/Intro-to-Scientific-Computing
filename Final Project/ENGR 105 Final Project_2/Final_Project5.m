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

% make the balloon
redBalloon = makeBalloon; 

% get the size of the screen and make the axes of the balloons this size
ss = get(0,'ScreenSize');
xlim([0,ss(3)+150])
ylim([0,ss(4)])

%use a timer to populate multiple balloons using the make and move
% balloon functions
t1 = timer('TimerFcn',@(~,~)moveBalloon(redBalloon),...
    'StopFcn', @stopTimer,'StartDelay',2,'Period',3,'TasksToExecute',5);
start(t1)
