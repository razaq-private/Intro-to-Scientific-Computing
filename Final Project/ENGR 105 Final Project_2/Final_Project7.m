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

% create graphics handle object describing Red Balloon
[redBalloon,~,alphaRedBalloon] = imread('redBalloon.png');

% vector to store the indices of the balloons
% delete one of the indices when a balloon is popped
balloons = [];

% populate all the balloons for the first round (10 red balloons)
for i = 1:10 
    % make the background of balloon transparent
    balloonObj(i) = imshow(redBalloon);
    balloonObj(i).AlphaData = alphaRedBalloon;
    balloonObj(i).Visible = 'on';

    % change scaling of balloon on axes
    balloonObj(i).XData = [1,0.5*balloonObj(i).XData(2)];
    balloonObj(i).YData = [1,0.5*balloonObj(i).YData(2)];

    % indicate the starting position of the balloon
    balloonObj(i).XData = 1-i*50;
    balloonObj(i).YData = 55;
    hold on
    
    % populate the balloon vector when a balloon is created
    balloons(end+1) = i;
end
hold off

% make the axes of the balloons this size
xlim([0,1430])
ylim([0,720])

timesteps = [75,25]
dx = [5,0]
dy = [0,5]
% 
% for m = 1:75
%     % For each balloon, update position
%     for k = 1:10
%         % Change position of image on axes
%         balloonObj(k).XData = balloonObj(k).XData+5;
%         % create if statements so that at each corner it turns
%     end
%     pause(0.1)
% end

% create a vector that contains what time step balloon is on
balloonStep = zeros(length(balloons));
% create a vector that contains if balloon has reached start position 
startPos = zeros(length(balloons));
gameStillGoing = 1;

% while the condition of the game still going is true
% the balloons will continue to increment by one time step
while gameStillGoing < 200
    
    % go through each of the balloons to increment them by one timestep
    for i = balloons
        
        if balloonStep(i) < 75 && balloonStep(i) ~=0
            balloonObj(i).XData = balloonObj(i).XData+5;
%         elseif balloonStep(i) < 100
%             balloonObj(i).YData = balloonObj(i).YData+5;
%         % make the balloon move right if it hasn't hit the start pos yet
%         else
%             balloonObj(i).XData = balloonObj(i).XData+5;
        end
        % if the balloon is at the end of the path
        % delete the balloon and the corresponding index
        
        % make the start position true if it hits the initial start pos
        % indicates that the balloon started on the path
        if balloonObj(i).XData == 1 && balloonObj(i).YData == 55
            startPos(i) == 1;
        end
        
        % increment the step by 1 only after it starts the 
        if startPos(i) == 1
            balloonStep(i) = balloonStep(i) + 1;
        end
       
    end
    gameStillGoing = gameStillGoing +1;
    pause(0.1)
end

% % use a timer to populate multiple balloons using the make and move
% % balloon functions
% t1 = timer('TimerFcn',@MoveBalloon(balloonObj(1:5)),...
%     'StopFcn', @stopTimer,'ExecutionMode','fixedSpacing',...
%     'Period',1,'TasksToExecute',5);
% start(t1)

% need to make it so that the screen size is uniform
% make multiple balloons move at once