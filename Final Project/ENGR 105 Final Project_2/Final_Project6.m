close all

% store map image in variable
map_image = imread('bloonsMap.png');

% create axes that are visible
g1 = axes('units','normalized', ...
            'position',[0,0,1,1]);
% stack the axes on the bottom        
uistack(g1,'bottom');

% read and show the image
g2 = imagesc(map_image);

% set the size of the map
xlim([0,700])
ylim([0,500])

% set the visibility of the axes to invisible
set(g1,'handlevisibility','off', ...
            'visible','on')
% enlarge to the full screen
set(gcf, 'units','normalized','outerposition',[0,0,1,1]);

g1Pos = get(g1,'position');
g3=axes('units','normalized', ...
        'position',[0,0,1,1]);

% use a timer to populate multiple balloons using the make and move
% balloon functions
t1 = timer('TimerFcn',@makeMoveBalloon,...
    'StopFcn', @stopTimer,'ExecutionMode','fixedSpacing',...
    'Period',1,'TasksToExecute',5);
start(t1)

% only moves one balloon at a time - probably a queing issue
% something with dropping 

% need to make it so that the screen size is uniform
% make multiple balloons move at once