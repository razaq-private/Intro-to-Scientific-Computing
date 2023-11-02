% Bloons TD - Tower Objects to be placed by user
close all
clear
% Create a figure to be associated with placing the tower
tFig1 = figure('Visible','on');
% g1 = axes;
% g1.Visible = "on";

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
    
% 2) Placing the towers - drag and drop

    % Change size of figure window
    tFig1.Position(3:4) = 2.0*tFig1.Position(3:4);
    
    % 'ind' will be used to track the index of the marker that is to be moved when a mouse movement is detected. 
    % An empty set indicates that no index has been selected.
    handles.ind = [];
    
    % Store guidata
    guidata(tFig1,handles);
    
    % Define scaling factor
    sf = 2.0;
    
    % Change the scaling of images on figure
    for k = 1:length(towerBank)
        towerBank(k).Graphic.XData = [1,sf*towerBank(k).Graphic.XData(2)];
        towerBank(k).Graphic.YData = [1,sf*towerBank(k).Graphic.YData(2)];
    end
    
    % Initialize the center locations of 3 towers.
    towerBank(1).Graphic.XData = towerBank(1).Graphic.XData;
    
    towerBank(2).Graphic.XData = towerBank(2).Graphic.XData + 300;
    
    towerBank(3).Graphic.XData = towerBank(3).Graphic.XData + 600;  

% 3) Upon placing have towers shoot according to their specific strategy
    
%     % Create timer function for shooting projectile
%     t_time = timer("TimerFcn",{@shoot,towerBank},"StopFcn",@stopTime,"StartDelay",2,"Period",2,"ExecutionMode","fixedRate", ...
%         "TasksToExecute",50);
    
    % Assign the callback functions for mouse drag and drop
    tFig1.WindowButtonDownFcn = {@pickTower,towerBank};
    tFig1.WindowButtonMotionFcn = {@moveTower,towerBank};
    tFig1.WindowButtonUpFcn = {@placeTower,towerBank};
    
    % More graphical parameters
    xlim([0,1000])
    ylim([0,1000])
    set(gca,"Visible","on");
    g1 = gca;
    % Change size of axes to match size of figure window
    g1.Position = [0,0.2,1.0,0.75];
    % Get rid of x and y axis limits
    set(g1,"XTick",[]);
    set(g1,"YTick",[]);

function pickTower(tFig1,~,towerBank)
     % Mouse button down callback. Determines if the mouse was    
     % clicked within the limits of a marker and, if so, takes    
     % control of the marker.
     
     handles = guidata(tFig1);
     
      % Get the location of the mouse.    
      pos = get(gca,'CurrentPoint');    
      xMouse = pos(1,1);    
      yMouse = pos(1,2);
      
      % Determine distance between current mouse position and the
      % centre-points of the images
      for k = 1:length(towerBank)
        distance(k) = sqrt((xMouse-sum(towerBank(k).Graphic.XData)/2)^2+(yMouse-sum(towerBank(k).Graphic.YData)/2)^2);
      end
      
      % Find which distance was the shortest hence the mouse is closest to
      % that tower
      [distance,minInd] = min(distance);
      
      % Length of diagonal of the tower mouse is closest to 
      diagonal = sqrt((towerBank(minInd).Graphic.XData(1)-towerBank(minInd).Graphic.XData(2))^2 + ...
          (towerBank(minInd).Graphic.YData(1)-towerBank(minInd).Graphic.YData(2))^2 );
      
      % If mouse is within rectangular box range of the image it is closest
      % to then take control of the tower centerpoint index
      if distance <= diagonal/2
            handles.ind = minInd;
      end
      
      guidata(tFig1,handles);
end

function moveTower(tFig1,~,towerBank)
    % Mouse motion callback. Moves the marker centerpoint    
    % held in x/y index 'ind' if 'ind' is not an empty set.   
    % Updates visuals accordingly.
    
    handles = guidata(tFig1);    
    ind = handles.ind;
    
     % Get the location of the mouse.    
     pos = get(gca,'CurrentPoint');    
     xMouse = pos(1,1);   
     yMouse = pos(1,2);
     
     if ~isempty(ind)     
         % Update the x/y centerpoint corresponding to 'ind'.
         width = diff(towerBank(ind).Graphic.XData); % Width of tower image
         height = diff(towerBank(ind).Graphic.YData); % Height of tower image
         towerBank(ind).Graphic.XData = [-width/2, width/2] + xMouse;   
         towerBank(ind).Graphic.YData = [-height/2, height/2] + yMouse;    
         drawnow
     end
end

function placeTower(tFig1,~,towerBank)
    % Mouse release callback. Upon release, tower that was moved should
    % begin shooting 
    handles = guidata(tFig1);
    ind = handles.ind;
    
    tower = towerBank(ind).Graphic;
  
    % Mouse up callback. Release control of 'ind'.
    handles.ind = [];    
    guidata(tFig1,handles); 
    
    width = diff(tower.XData); % Width of tower image
    height = diff(tower.YData); % Height of tower image
    
    numTimers = 10;
    
    % Create an array of timers that represent that number of bullets or
    % ammo capacity of a tower. Each bullet is made and moved by its own
    % timer
    for k = 1:numTimers
        t_time(k) = timer("TimerFcn",{@moveshot,tFig1},"StartFcn",{@shoot,tFig1}, "StopFcn", {@stopTime},"Period",0.1,"ExecutionMode","fixedRate", ...
             "TasksToExecute",3);
    end
    
    % Loop through and start each timer
    for k = 1:numTimers
        start(t_time(k));
    end
    
    function shoot(~,~,tFig1)
        % Timer start function that first draws a bullet upon mouse
        % release
        
        % Load guidata and retrieve index for tower from handles
        handles = guidata(tFig1);
        ind = handles.ind;
    
        width = diff(tower.XData); % Width of tower image
        height = diff(tower.YData); % Height of tower image
        
        % Load guidata into handles struct
        %handles = guidata(h1);
        
        hold on        
        % Draw a bullet
        c = rectangle("Position",[tower.XData(2),tower.YData(1) + height/2,30,30],"Curvature",[1,1],"FaceColor","r");
        
        % Store the bullet graphics object in handles struct
        handles.rect = c;
        
        % Save guidata
        guidata(tFig1,handles);
    end
    
     function moveshot(~,~,tFig1)
        % Timer function that moves bullets across the screen 
        handles = guidata(tFig1);
        
        % Load the bullet graphic object created from the start function
        c = handles.rect;
        
        % Move across the screen for 10 increments of 10
        for i = 1:10
            c.Position(1) = c.Position(1) + 10;
            pause(0.05);
        end
        
        drawnow;
     end
    
    function stopTime(t_time,~)
        % Stop timer function that deletes each bullet once it has moved
        % and the timer associated with each bullet
        c = handles.rect;
        delete(c)
        delete(t_time);
    end    
end















