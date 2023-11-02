function placeTower(h1,~,towerBank)
    % Mouse release callback. Upon release, tower that was moved should
    % begin shooting 
    handles = guidata(h1);
    ind = handles.ind;
    
    tower = towerBank(ind).Graphic;
  
    % Mouse up callback. Release control of 'ind'.
    handles.ind = [];    
    guidata(h1,handles); 
    
    width = diff(tower.XData); % Width of tower image
    height = diff(tower.YData); % Height of tower image
    
    numTimers = 10;
    
    % Create an array of timers that represent that number of bullets or
    % ammo capacity of a tower. Each bullet is made and moved by its own
    % timer
    for k = 1:numTimers
        t_time(k) = timer("TimerFcn",{@moveshot,h1},"StartFcn",{@shoot,h1}, "StopFcn", {@stopTime},"Period",0.1,"ExecutionMode","fixedRate", ...
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