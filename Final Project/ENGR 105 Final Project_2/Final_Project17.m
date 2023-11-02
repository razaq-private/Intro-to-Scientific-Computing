close all
clear

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
% turn tick marks off
set(gca,'xtick',[])
set(gca,'ytick',[])
        
% stack the axes on the bottom        
uistack(g1,'bottom'); 

% read and show the image
g1_image = imagesc(map_image);

% set the visibility of the axes to invisible
set(g1,'handlevisibility','off','visible','on')
% denote the size of the map so that it is the same size for all computers
set(h1,'position',[.2,.2,1280,650])
% disable the zoom for the g1 axes 
disableDefaultInteractivity(g1);

% create a second set of axes for the balloons
g2=axes('units','normalized','position',[0,0,1,1]);
% turn tick marks off
set(gca,'xtick',[]);
set(gca,'ytick',[]);

%----------------------------------- End of Map Code

% ------------------------------------------
% Handles/GUI Code

% create data structure to store info about interface
handles = struct;

% initialize the balloons that will be inputed
handles.balloonObj = [];
handles.balloonStep = zeros(1,50);
handles.startPos = zeros(1,50);
% 'ind' will be used to track the index of the marker that is to be moved when a mouse movement is detected. 
% An empty set indicates that no index has been selected.
handles.ind = [];
% initialize logical scalar that encodes if the tower has been selected
handles.selected = 0;
% initialize scalar with the number of bananas
handles.bananas = 0;
% initialize the number of bananas
handles.points = 0;
% initialize rectangle position for the bullets
handles.rectPos = [];

% store data structure as GUI data
guidata(h1,handles);

%----------------------------------- End of Handles/GUI Code

% ------------------------------------------
% Balloon Code

% vectors to demote how many of each balloon
numRed = 20;
numBlue = 20;
numGreen = 10;

% vector to encode total number of balloons
% this is updated in the healthbar function
numActiveBalloons = 1:numRed+numBlue+numGreen;

% populate all the balloons
[redBalloonVec] = makeBalloon(h1,numRed,'redBalloon.png',1);
[blueBalloonVec] = makeBalloon(h1,numBlue,'blueBalloon.png',2);
[greenBalloonVec] = makeBalloon(h1,numGreen,'greenBalloon.png',3);
hold off

% make the axes of the balloons and counter this size
xlim([0,1450])
ylim([0,670])
% disable the zoom for the g2 axes 
disableDefaultInteractivity(g2);

%----------------------------------- End of Balloons Code

% ------------------------------------------
% Graphics Code

% graphics for health bar (damage is encoded in guidata)
boundaryHealth = rectangle('Position',[900 15 500 20], 'LineWidth', 3);
health = rectangle('Position',[900 15 500 20], 'FaceColor', 'green');
damage = rectangle('Position', [900 15 0 20], 'FaceColor', 'red');

% graphics for bananas counter
% add an "edit text" box to show the current value of the counter
bananaScore = uicontrol('Style','edit','Units','Normalized','Position',...
[0.875,0.825,0.075,0.03],'FontSize',10,'String',handles.bananas);
% display text that says 'bananas'
uicontrol('Style','text','Units','Normalized','Position',...
bananaScore.Position + [0,0.03,0,0],'FontSize',10,'String','Bananas');
% prevent user from editing the textbox manually
set(bananaScore, 'enable', 'inactive');

% graphics for points counter
% add an "edit text" box to show the current value of the counter
pointScore = uicontrol('Style','edit','Units','Normalized','Position',...
[0.75,0.825,0.075,0.03],'FontSize',10,'String',handles.points);
% display text that says 'bananas'
uicontrol('Style','text','Units','Normalized','Position',...
pointScore.Position + [0,0.03,0,0],'FontSize',10,'String','Points');
% prevent user from editing the textbox manually
set(pointScore, 'enable', 'inactive');

%----------------------------------- End of Graphics Code

% declare the variable to be true (start the game)
gameStillGoing = true;

% use countdown function to countdown before game starts
% countdown;

% ------------------------------------------
% Tower Code

% create a third set of axes for the towers
g3=axes('units','normalized','position',[0,0,1,1]);
% turn tick marks off
set(gca,'xtick',[]);
set(gca,'ytick',[]);
xlim([0,1450])
ylim([0,670])
% stack the axes on the bottom        
uistack(g3,'top'); 
% disable the zoom for the g1 axes 
disableDefaultInteractivity(g3);

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
%-----------------End of Part 1 of Tower Code
%--------------
% Part 2 of Tower Code

% 2) Placing the towers - drag and drop

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
h1.WindowButtonDownFcn = {@pickTower,towerBank};
h1.WindowButtonMotionFcn = {@moveTower,towerBank};
h1.WindowButtonUpFcn = {@placeTower1,towerBank};
%----------------------------------- End of Tower Code 

% Load and update handles structure and guidata
handles = guidata(h1);

% move the balloons
t_redBalloons = timer("TimerFcn",{@moveBalloon7,h1,redBalloonVec,0,bananaScore,pointScore,damage},...
    "StopFcn",{@stopTimer},"Period",0.1,"ExecutionMode","fixedRate", ...
     "TasksToExecute",800);

%         t_blueBalloons = timer("TimerFcn",{@moveBalloon7,h1,blueBalloonVec,numRed,damage},...
%             "StopFcn", {@stopTimer},"Period",0.01,"ExecutionMode","fixedRate", ...
%              "TasksToExecute",800,"StartDelay",10);
%         t_greenBalloons = timer("TimerFcn",{@moveBalloon7,h1,greenBalloonVec,numRed+numBlue,damage},...
%             "StopFcn", {@stopTimer},"Period",0.01,"ExecutionMode","fixedRate", ...
%              "TasksToExecute",900,"StartDelay",20);

 start([t_redBalloons])%,t_blueBalloons,t_greenBalloons])


