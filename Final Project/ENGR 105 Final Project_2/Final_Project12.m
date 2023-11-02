close all

% ------------------------------------------
% Map Code

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

%----------------------------------- End of Map Code

% ------------------------------------------
% Handles/GUI Code

% create data structure to store info about interface
handles = struct;
% initialize the field that will be inputed
handles.balloonObj = [];
% 'ind' will be used to track the index of the marker that is to be moved when a mouse movement is detected. 
% An empty set indicates that no index has been selected.
handles.ind = [];
% store data structure as GUI data
guidata(h1,handles);

%----------------------------------- End of Handles/GUI Code

% ------------------------------------------
% Tower Code

% 1) Creating and storing different tower objects with respective
% strategies

%     % Initialize a tower bank that will store all the tower graphics
%     % objects and their respective strategies in a structure array
%     towerBank = struct('Graphic',[],'Strategy',[]);
%     
%     % Define number of towers to be used
%     numTowers = 3;
%     
%     % Populate graphic field of struct array with empty graphic object
%     % placeholder
%     for k = 1:numTowers  
%         towerBank(end+1).Graphic = gobjects(1);
%     end
%     
%     % Delete empty first entry
%     towerBank(1) = [];
%     
%     % Strategies - radii of attack
%     attackRadii = [2,4,6];
%     
%     % Define strategies for each tower. Strategy here simply refers to the
%     % radius of attack
%     for k = 1:length(towerBank)
%         towerBank(k).Strategy = attackRadii(k);
%     end    
%     
%     % Basename for files
%     baseName = "Tower";
%     
%     % Load and store the tower images as the graphic objects
%     towerImages = dir;
%     for k = 1:length(towerBank)
%         hold on
%         [~,~,alphaTower] = imread(strcat(baseName,num2str(k),".png")); % 
%         towerBank(k).Graphic = imshow(imread(towerImages(k+16).name));
%         towerBank(k).Graphic.AlphaData = alphaTower;
%     end
%     hold off

% 2) Placing the towers - drag and drop

%     % Change size of figure window
%     tFig1.Position(3:4) = 2.0*tFig1.Position(3:4);
    
%     % 'ind' will be used to track the index of the marker that is to be moved when a mouse movement is detected. 
%     % An empty set indicates that no index has been selected.
%     handles.ind = [];
    
%     % Store guidata
%     guidata(h1,handles);
    
%     % Define scaling factor
%     sf = 2.0;
%     
%     % Change the scaling of images on figure
%     for k = 1:length(towerBank)
%         towerBank(k).Graphic.XData = [1,sf*towerBank(k).Graphic.XData(2)];
%         towerBank(k).Graphic.YData = [1,sf*towerBank(k).Graphic.YData(2)];
%     end
    
%     % Initialize the center locations of 3 towers.
%     towerBank(1).Graphic.XData = towerBank(1).Graphic.XData;
%     
%     towerBank(2).Graphic.XData = towerBank(2).Graphic.XData + 300;
%     
%     towerBank(3).Graphic.XData = towerBank(3).Graphic.XData + 600;  
    
%     % Assign the callback functions for mouse drag and drop
%     h1.WindowButtonDownFcn = {@pick,towerBank};
%     h1.WindowButtonMotionFcn = {@move,towerBank};
%     h1.WindowButtonUpFcn = @place;
    
%     % More graphical parameters
%     xlim([0,1000])
%     ylim([0,1000])
%     set(gca,"Visible","on");
%     g1 = gca;
%     % Change size of axes to match size of figure window
%     g1.Position = [0,0.2,1.0,0.75];
%     % Get rid of x and y axis limits
%     set(g1,"XTick",[]);
%     set(g1,"YTick",[]);

%----------------------------------- End of Tower Code

% populate all the balloons for the first round (10 red balloons)
[redBalloonVec] = makeBalloon(h1,10,'redBalloon.png',1);
[blueBalloonVec] = makeBalloon(h1,10,'blueBalloon.png',2);
hold off

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

% pause two seconds before the balloons begin to move
pause(2)

% declare the variables to be used in functions
redStartPos = zeros(1,length(redBalloonVec));
redBalloonStep = zeros(1,length(redBalloonVec));
blueStartPos = zeros(1,length(blueBalloonVec));
blueBalloonStep = zeros(1,length(blueBalloonVec));

% while the condition of the game still going is true
% the balloons will continue to increment by one time step
while gameStillGoing
    % move the red balloons
    [redBalloonStep,redStartPos] = moveBalloon(h1,redBalloonVec,redBalloonStep,redStartPos,0,1);
    % move the blue balloons
    [blueBalloonStep,blueStartPos] = moveBalloon(h1,blueBalloonVec,blueBalloonStep,blueStartPos,10,2);
    % check the health bar
    [gameStillGoing,damage] = healthBar(h1,damage,gameStillGoing);
end