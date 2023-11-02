close all

% store map image in variable
map_image = imread('bloonsMap.png');

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
set(gcf,'position',[.2,.2,1280,650])

% create a second set of axes for the balloons
g2=axes('units','normalized','position',[0,0,1,1]);

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
    balloonObj(i).YData = 30;
    hold on
    
    % populate the balloon vector when a balloon is created
    balloons(end+1) = i;
end
hold off

% make the axes of the balloons this size
xlim([0,1450])
ylim([0,670])

% create a vector that contains what time step balloon is on
balloonStep = zeros(1,length(balloons));
% create a vector that contains if balloon has reached start position 
startPos = zeros(1,length(balloons));
endPos = zeros(length(balloons));
gameStillGoing = 1;

%health stuffs
boundaryHealth = rectangle('Position',[10 15 500 20], 'LineWidth', 3)
health = rectangle('Position',[10 15 500 20], 'FaceColor', 'green')
damage = rectangle('Position', [10 15 0 20], 'FaceColor', 'red')
% vector that encodes the specific time steps for each stretch of path
timeSteps = [67,90,136,160,212,260,310,360,410,430,480,500,570];

% % pause two seconds before the balloons begin to move
% pause(2)

% while the condition of the game still going is true
% the balloons will continue to increment by one time step
while gameStillGoing < 1000
    
    % go through each of the balloons to increment them by one timestep
    for i = balloons
        
        % hard code of the steps that the balloons should be moving
        % to follow the path
        
        % make the balloon move right if it hasn't hit the start pos yet
        if balloonStep(i) == 0
            balloonObj(i).XData = balloonObj(i).XData+5;
        % path 1    
        elseif balloonStep(i) < timeSteps(1) && balloonStep(i) ~=0
            balloonObj(i).XData = balloonObj(i).XData+5;
        % path 2
        elseif balloonStep(i) >= timeSteps(1) && balloonStep(i) < timeSteps(2)  
            balloonObj(i).YData = balloonObj(i).YData+5;
        % path 3
        elseif balloonStep(i) >= timeSteps(2) && balloonStep(i) < timeSteps(3)
            balloonObj(i).XData = balloonObj(i).XData+5;
        % path 4
        elseif balloonStep(i) >= timeSteps(3) && balloonStep(i) < timeSteps(4) 
            balloonObj(i).YData = balloonObj(i).YData-5;
        % path 5
        elseif balloonStep(i) >= timeSteps(4) && balloonStep(i) < timeSteps(5)
            balloonObj(i).XData = balloonObj(i).XData+5;
        % path 6
        elseif balloonStep(i) >= timeSteps(5) && balloonStep(i) < timeSteps(6)
            balloonObj(i).YData = balloonObj(i).YData+5;    
        % path 7
        elseif balloonStep(i) >= timeSteps(6) && balloonStep(i) < timeSteps(7)
            balloonObj(i).XData = balloonObj(i).XData-5; 
        % path 8
        elseif balloonStep(i) >= timeSteps(7) && balloonStep(i) < timeSteps(8)
            balloonObj(i).YData = balloonObj(i).YData+5;              
        % path 9
        elseif balloonStep(i) >= timeSteps(8) && balloonStep(i) < timeSteps(9)
            balloonObj(i).XData = balloonObj(i).XData+5;
        % path 10
        elseif balloonStep(i) >= timeSteps(9) && balloonStep(i) < timeSteps(10)
            balloonObj(i).YData = balloonObj(i).YData-5;
        % path 11
        elseif balloonStep(i) >= timeSteps(10) && balloonStep(i) < timeSteps(11)
            balloonObj(i).XData = balloonObj(i).XData+5;
        % path 12
        elseif balloonStep(i) >= timeSteps(11) && balloonStep(i) < timeSteps(12)
            balloonObj(i).YData = balloonObj(i).YData+5;
        % path 13
        elseif balloonStep(i) >= timeSteps(12) && balloonStep(i) < timeSteps(13)
            balloonObj(i).XData = balloonObj(i).XData+5; 
        % when the balloon hits the end of the path, then make the balloon
        % disappear
        else
            balloonObj(i).Visible = 'off';
            startPos(i) = 0;
            balloonStep(i) = NaN;
            damage.Position(3) = damage.Position(3)+10;
            if damage.Position(3) == 500
                gameStillGoing = 1001;
            end
        end    
        
        % make the start position true if it hits the initial start pos
        % indicates that the balloon started on the path
        if balloonObj(i).XData == 1 && balloonObj(i).YData == 30
            startPos(i) = 1;
        end
          
        % increment the step by 1 only after it starts the 
        if startPos(i) == 1
            balloonStep(i) = balloonStep(i) + 1;
        end
        
%         if balloonObj(i).XData == 1412 && balloonObj(i).YData == 515
%             endPos(i) = 1;
%         end
%         
%         if endPos(i) == 1
%             damage.Position(3) = damage.Position(3)+10;
%             if damage.Position(3) == 500
%                 gameStillGoing = 1001;
%             end
%         end 
        
       
    end
    
    gameStillGoing = gameStillGoing +1;
    pause(0.01)
    
end