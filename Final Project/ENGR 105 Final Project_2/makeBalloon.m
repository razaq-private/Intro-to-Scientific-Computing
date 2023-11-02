% function inputs are the figure (h1), a scalar defining number of
% balloons, balloon image as a png, and a scalar defining what order these
% ballons are

% function outputs a balloon vector of how many balloons there based on
% numBalloons

function [balloonVec] = makeBalloon(h1,numBalloons,balloonImage,order)    
    % retrieve the GUI data
    handles = guidata(h1);
    
    % create graphics handle object describing the balloon
    [Balloon,~,alphaBalloon] = imread(balloonImage);
    
    % get the size of the image to scale it down
    [rows, columns, numberOfColorChannels] = size(Balloon);
    
    % find the scale factor to make balloon predetermined size
    sf = 63/rows;
    % resize the balloon and alpha data
    Balloon = imresize(Balloon,sf);
    alphaBalloon = imresize(alphaBalloon,sf);
    
    % vector to store the indices of the balloons
    % delete one of the indices when a balloon is popped
    balloonVec = [];
    
    % when the order of the balloon is greater than one
    % meaning other balloons have been previously created
    if order > 1
        % get the previous gui data
        hBalloonObj = handles.balloonObj;
        % create a vector that stores how many balloons were previously made
        prevBalloons = length(hBalloonObj);
    % otherwise, do not need to account for additional balloons
    else
        prevBalloons = 0;
    end
    
    for i = 1:numBalloons  
        % make the background of balloon transparent
        hBalloonObj(i+prevBalloons) = imshow(Balloon);
        hBalloonObj(i+prevBalloons).AlphaData = alphaBalloon;
        hBalloonObj(i+prevBalloons).Visible = 'on';

        % indicate the starting position of the balloon
        % the starting x position is off the screen of the map
        % use the order to separate the distance of the balloons
        hBalloonObj(i+prevBalloons).XData = 1 - (i*50) - ((order-1)*100);
        hBalloonObj(i+prevBalloons).YData = 30;
        hold on

        % populate the balloon vector when a balloon is created
        balloonVec(end+1) = i;
    end
    
    % save the graphic objects in the GUI data
    handles.balloonObj = hBalloonObj;
    guidata(h1,handles);
end    