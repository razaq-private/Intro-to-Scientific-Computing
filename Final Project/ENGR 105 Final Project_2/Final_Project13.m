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

% make the axes of the balloons this size
xlim([0,1450])
ylim([0,670])
% disable the zoom for the g2 axes 
disableDefaultInteractivity(g2);

%----------------------------------- End of Balloons Code

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

% create instructions for how the user should play
arrow1 = annotation('textarrow',[.65,0.75],[.75,0.825]);
dim1 = [.5 .45 .3 .3];
str1 = 'Accumulate points by popping balloons';
text1 = annotation('textbox',dim1,'String',str1,'FitBoxToText','on','BackgroundColor','w');

arrow2 = annotation('textarrow',[.85,0.9],[.75,0.825]);
dim2 = [.7 .45 .3 .3];
str2 = 'Use bananas to buy more monkeys to pop balloons';
str2 = [str2 newline 'Bananas populate automatically'];
str2 = [str2 newline 'but populate faster with banana towers'];
text2 = annotation('textbox',dim2,'String',str2,'FitBoxToText','on','BackgroundColor','w');

% use countdown function to countdown before game starts
countdown;

% while the condition of the game still going is true
% the balloons will continue to increment by one time step
while gameStillGoing
    % move the red balloons
    [redBalloonStep,redStartPos] = moveBalloon(h1,redBalloonVec,redBalloonStep,redStartPos,0,1);
    % move the blue balloons
    [blueBalloonStep,blueStartPos] = moveBalloon(h1,blueBalloonVec,blueBalloonStep,blueStartPos,numRed,2);
    % move the green balloons
    [greenBalloonStep,greenStartPos] = moveBalloon(h1,greenBalloonVec,greenBalloonStep,greenStartPos,numRed+numBlue,3);
    % add bananas to the counter
    bananaCounter(h1,bananaScore);    
    % increase the score if the player hits a balloon
    pointCounter(h1,pointScore);
    % check the health bar and game status
    [gameStillGoing,damage,numActiveBalloons] = healthBar(h1,damage,numActiveBalloons,gameStillGoing);
    
    if ~gameStillGoing 
        % Create figure objects
        %h2 = figure('Visible','on');
        %g1 = axes;
   
        % Create button to reset the game 
        u1 = uicontrol('Style','pushbutton','Units','Normalized','Position',...
         [0,0.4,0.2,0.2],'String','New Game');

        u1.Callback = {@resetGame,h1,redStartPos,redBalloonStep,blueStartPos,...
            blueBalloonStep,greenStartPos,greenBalloonStep,damage,...
            boundaryHealth,health,redBalloonVec,blueBalloonVec,greenBalloonVec...
            ,u1,@makeBalloon,@moveBalloon,@healthBar};
    end
    
end