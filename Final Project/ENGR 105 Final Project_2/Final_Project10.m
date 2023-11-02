close all

% create map and background axes for balloons
% store map image in variable
map_image = imread('bloonsMap.png');

% create a figure window that is visible
h1 = figure('Visible','on');
% create axes that are visible
g1 = axes('units','normalized', ...
            'position',[0,0,1,1]);
% stack the axes on the bottom        
uistack(g1,'bottom');

% read and show the image
g1_image = imagesc(map_image);

% set the visibility of the axes to invisible
set(g1,'handlevisibility','off','visible','on')
% denote the size of the map so that it is the same size for all computers
set(h1,'position',[.2,.2,1280,650])

% create a second set of axes for the balloons
g2=axes('units','normalized','position',[0,0,1,1]);
% disable the zoom for the g2 axes 
disableDefaultInteractivity(g1);

% create data structure to store info about interface
handles = struct;
% store data structure as GUI data
guidata(h1,handles);
% initialize the field that will be inputed
handles.balloonObj = [];

% populate all the balloons for the first round (10 red balloons)
[redBalloonVec] = makeBalloon(h1,10,'redBalloon.png');

% make the axes of the balloons this size
xlim([0,1450])
ylim([0,670])
% disable the zoom for the g2 axes 
disableDefaultInteractivity(g2);

% declare the variable to be true (start the game)
gameStillGoing = true;

% graphics for health bar
boundaryHealth = rectangle('Position',[900 15 500 20], 'LineWidth', 3);
health = rectangle('Position',[900 15 500 20], 'FaceColor', 'green');
damage = rectangle('Position', [900 15 0 20], 'FaceColor', 'red');

startPos = zeros(1,length(redBalloonVec));
balloonStep = zeros(1,length(redBalloonVec));

% pause two seconds before the balloons begin to move
pause(2)

% while the condition of the game still going is true
% the balloons will continue to increment by one time step
while gameStillGoing
    [balloonStep,startPos] = moveBalloon(h1,redBalloonVec,0.01,balloonStep,startPos);
    [gameStillGoing,damage] = healthBar(h1,redBalloonVec,damage,gameStillGoing);
end