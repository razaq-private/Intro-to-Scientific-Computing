close all
clear
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
% initialize the field that will be inputed
handles.balloonObj = [];
% 'ind' will be used to track the index of the marker that is to be moved when a mouse movement is detected. 
% An empty set indicates that no index has been selected.
handles.ind = [];
% store data structure as GUI data
guidata(h1,handles);

% populate all the balloons for the first round (10 red balloons)
[redBalloonVec] = makeBalloon(h1,10,'redBalloon.png',1);

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

% ------------------------------------------
% Tower Code

% 1) Creating and storing different tower objects with respective
% strategies

    % Initialize a tower bank that will store all the tower graphics
    % objects and their respective strategies in a structure array
    towerBank = struct('Graphic',[],'Strategy',[]);
    
    % Define number of towers to be used
    numTowers = 3;
    
    % Populate graphic field of struct array with empty graphic object
    % placeholder
    for k = 1:numTowers  
        towerBank(end+1).Graphic = gobjects(1);
    end
    
    % Delete empty first entry
    towerBank(1) = [];
    
    % Strategies - direction of attack
    attackDir= ["up","down","right"];
    
    % Define strategies for each tower. Strategy here simply refers to the
    % direction of attack
    for k = 1:length(towerBank)
        towerBank(k).Strategy = attackDir(k);
    end   
    
    % Basename for files
    baseName = "Tower";
    
    % Load and store the tower images as the graphic objects
    towerImages = dir('Tower Images');
    for k = 1:length(towerBank)
        hold on
        [~,~,alphaTower] = imread(strcat(baseName,num2str(k),".png")); % 
        towerBank(k).Graphic = imshow(imread(towerImages(k+3).name));
        towerBank(k).Graphic.AlphaData = alphaTower;
    end
    hold off

% 2) Placing the towers - drag and drop
    
%     % 'ind' will be used to track the index of the marker that is to be moved when a mouse movement is detected. 
%     % An empty set indicates that no index has been selected.
%     handles.ind = [];
    
%     % Store guidata
%     guidata(h1,handles);
    
    % Define scaling factor
    sf = 0.75;
    
    % Change the scaling of images on figure
    for k = 1:length(towerBank)
        towerBank(k).Graphic.XData = [1,sf*towerBank(k).Graphic.XData(2)];
        towerBank(k).Graphic.YData = [1,sf*towerBank(k).Graphic.YData(2)];
    end
    
    % Initialize the center locations of 3 towers.
    towerBank(1).Graphic.XData = towerBank(1).Graphic.XData;
    towerBank(1).Graphic.YData = towerBank(1).Graphic.YData + 500;
    
    towerBank(2).Graphic.XData = towerBank(2).Graphic.XData + 200;
    towerBank(2).Graphic.YData = towerBank(2).Graphic.YData + 500;
    
    towerBank(3).Graphic.XData = towerBank(3).Graphic.XData + 400;
    towerBank(3).Graphic.YData = towerBank(3).Graphic.YData + 500;
    
    % Assign the callback functions for mouse drag and drop
    h1.WindowButtonDownFcn = {@pickTower1,towerBank};
    h1.WindowButtonMotionFcn = {@moveTower,towerBank};
    h1.WindowButtonUpFcn = {@placeTower1,towerBank};
%----------------------------------- End of Tower Code

% startPos = zeros(1,length(redBalloonVec));
% balloonStep = zeros(1,length(redBalloonVec));
% 
% % pause two seconds before the balloons begin to move
% pause(2)
% 
% % while the condition of the game still going is true
% % the balloons will continue to increment by one time step
% while gameStillGoing
%     [balloonStep,startPos] = moveBalloon(h1,redBalloonVec,0.01,balloonStep,startPos);
%     [gameStillGoing,damage] = healthBar(h1,redBalloonVec,damage,gameStillGoing);
% end