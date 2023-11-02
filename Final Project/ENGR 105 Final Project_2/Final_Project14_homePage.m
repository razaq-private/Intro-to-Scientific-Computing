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

% create a second set of axes for the balloons
g2=axes('units','normalized','position',[0,0,1,1]);
% turn tick marks off
set(gca,'xtick',[]);
set(gca,'ytick',[]);
% disable the zoom for the g1 axes 
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
% initialize the number of bananas
handles.bananas = 0;
% initialize the number of bananas
handles.points = 0;
% intialize home page check
handles.homePage = true;

% store data structure as GUI data
guidata(h1,handles);

%----------------------------------- End of Handles/GUI Code

% ------------------------------------------
% Balloon Code

% vectors to demote how many of each balloon
numRed = 20;
numBlue = 20;
numGreen = 10;

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


% create axes for home page
g3 = axes('units','normalized','position',[0,0,1,1]);
% turn tick marks off
set(gca,'xtick',[]);
set(gca,'ytick',[]);

startButton = uicontrol('Style','pushbutton','Units','Normalized','Position',...
         [0.2,0.4,0.2,0.2],'String','Start');
helpButton = uicontrol('Style','pushbutton','Units','Normalized','Position',...
         [0.6,0.4,0.2,0.2],'String','Help');

startButton.Callback = {@startGame,h1,g3,startButton,helpButton};
disp(handles.homePage)


    % ------------------------------------------
    % Graphics Code

    % graphics for health bar
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

    % declare the variables to be used in functions
    redStartPos = zeros(1,length(redBalloonVec));
    redBalloonStep = zeros(1,length(redBalloonVec));
    blueStartPos = zeros(1,length(blueBalloonVec));
    blueBalloonStep = zeros(1,length(blueBalloonVec));
    greenStartPos = zeros(1,length(greenBalloonVec));
    greenBalloonStep = zeros(1,length(greenBalloonVec));

    % vector to encode total number of balloons
    % this is updated in the healthbar function
    numActiveBalloons = 1:numRed+numBlue+numGreen;

    % use countdown function to countdown before game starts
    countdown;

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

        % Strategies - radii of attack
        attackRadii = [2,4,6];

        % Define strategies for each tower. Strategy here simply refers to the
        % radius of attack
        for k = 1:length(towerBank)
            towerBank(k).Strategy = attackRadii(k);
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

    pause(5);

    % create axes for home page


 
    % while the condition of the game still going is true
    % the balloons will continue to increment by one time step
%     while gameStillGoing   
%        
%         % Assign the callback functions for mouse drag and drop
%         h1.WindowButtonDownFcn = {@pickTower,towerBank};
%         h1.WindowButtonMotionFcn = {@moveTower,towerBank};
%         h1.WindowButtonUpFcn = {@placeTower,towerBank};
%         %----------------------------------- End of Tower Code 
%         
%         % Load and update handles structure and guidata
%         handles = guidata(h1);
%         
%         % move the red balloons
%         [redBalloonStep,redStartPos] = moveBalloon(h1,redBalloonVec,redBalloonStep,redStartPos,0,1);
%         % move the blue balloons
%         [blueBalloonStep,blueStartPos] = moveBalloon(h1,blueBalloonVec,blueBalloonStep,blueStartPos,numRed,2);
%         % move the green balloons
%         [greenBalloonStep,greenStartPos] = moveBalloon(h1,greenBalloonVec,greenBalloonStep,greenStartPos,numRed+numBlue,3);
%         % add bananas to the counter
%         bananaCounter(h1,bananaScore);    
%         % increase the score if the player hits a balloon
%         pointCounter(h1,pointScore);
%         % check the health bar and game status
%         [gameStillGoing,damage,numActiveBalloons] = healthBar(h1,damage,numActiveBalloons,gameStillGoing);
%         pause(0.05)
%     end

