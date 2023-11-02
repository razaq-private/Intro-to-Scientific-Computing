% Bloons TD - Tower Objects to be placed by user
close all

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
    
    % Load and store the tower images as the graphic objects
    towerImages = dir;
    for k = 1:length(towerBank)
        hold on
        towerBank(k).Graphic = imshow(imread(towerImages(k+3).name));
    end
    hold off
    
% 2) Placing the towers - drag and drop

    % Create a figure to be associated with placing the tower
    tFig1 = figure('Visible','on');
    
    % Diameter of the towers
    D = 1;
    
    % 'ind' will be used to track the index of the marker that is to be moved when a mouse movement is detected. 
    % An empty set indicates that no index has been selected.
    handles.ind = [];
    
    % Store guidata
    guidata(tFig1,handles);
    
%     % Initialize and draw the 3 towers
%     t1 = rectangle('Position',[(5-D)+D/2,(5-D)+D/2,2,2],'Curvature')
    
    % Initialize the center locations of 3 towers.
    x = (5-D)*ones(1,3)+D/2;
    y = [1,1.5,2.0].*x;
    
    % Plot the towers.
    p = plot(x,y,'ko');    
    
    % Create a mouse callback function that places the square anywhere on axis
    %tFig1.WindowButtonDownFcn = @towerPlace; 
    
    % Adjust the axis scaling so that the radius of the markers is
    % scaled to the size of the axes.
    axis equal
    axis([0 10 0 10])
    ax = gca;
    ax.Units = 'points';
    p(1).MarkerSize = D/diff(xlim)*ax.Position(3);
    
    % Assign the callback functions for mouse drag and drop
    tFig1.WindowButtonDownFcn = {@pick,D,p};
    tFig1.WindowButtonMotionFcn = {@move,p};
    tFig1.WindowButtonUpFcn = @place;
    
    % More graphical parameters
    set(gca,'XTick',[])
    set(gca,'YTick',[])

function towerPlace(h,~)
    % This function is responsible for placing a square tower down
    % once a player has clicked somewhere on the figure
    
    % Retrieve the current X and Y coordinates of the mouse
    pos = get(gca,'CurrentPoint');
    pos = pos(1,1:2);
    
    % Store width and height of the tower
    width = 1;
    height = 1;
    
%     % Load the map informtaion
%     map_handle = guidata(tFig1);

    % Place the tower with a left-click only
    if strcmp(h.SelectionType,'normal')
    
        % Update position of the tower to coordinates of where mouse is clicked
        rectangle('Position',[pos(1)-0.5*width,pos(2)-0.5*height,1,1]);
        
        drawnow
    end

%     % Save map data
%     guidata(tFig1,map_handle);
end

function pick(tFig1,~,D,p)
     % Mouse button down callback. Determines if the mouse was    
     % clicked within the limits of a marker and, if so, takes    
     % control of the marker.
     
     handles = guidata(tFig1);
     
      % Get the location of the mouse.    
      pos = get(gca,'CurrentPoint');    
      xMouse = pos(1,1);    
      yMouse = pos(1,2);
      
      % Determine which marker centerpoint the mouse is closest    
      % to and record the vector index number.    
      [distance,minInd] = min(sqrt((xMouse-p.XData).^2+(yMouse-p.YData).^2));
      
       % If the mouse is within a radius of the marker, then
       % take control of the x/y marker centerpoint index and    
       % calculate the difference between the centerpoint of the
       % marker and where the user actually clicked.
       if distance <= D/2        
           handles.ind = minInd;    
       end
       
       guidata(tFig1,handles);
end

function move(tFig1,~,p)
    % Mouse motion callback. Moves the marker centerpoint    
    % held in x/y index 'ind' if 'ind' is not an empty set.   
    % Updates visuals accordingly.
    
    handles = guidata(tFig1);    
    ind = handles.ind;
    
     % Get the location of the mouse.    
     pos = get(gca,'CurrentPoint');    
     xMouse = pos(1,1);   
     yMouse = pos(1,2);
     
     % Update the x/y centerpoint corresponding to 'ind'.    
     p.XData(ind) = xMouse;   
     p.YData(ind) = yMouse;    
     drawnow
end

function place(tFig1,~)
    % Mouse up callback. Release control of 'ind'.
    handles = guidata(tFig1);    
    handles.ind = [];    
    guidata(tFig1,handles);
end

function strat1(tFig1,~)
    
end
















