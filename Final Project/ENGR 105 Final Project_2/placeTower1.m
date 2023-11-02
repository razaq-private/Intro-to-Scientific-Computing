function placeTower1(h1,~,towerBank)
    % Mouse release callback. Upon release, tower that was moved should
    % begin shooting 
    handles = guidata(h1);
    ind = handles.ind;
    
    % Pull out the tower graphic object and the direction of attack 
    tower = towerBank(ind).Graphic;
    attDir = towerBank(ind).Strategy;
    
    width = diff(tower.XData); % Width of tower image
    height = diff(tower.YData); % Height of tower image
  
    % Mouse up callback. Release control of 'ind'.
%     if handles.bananas >= 1000
        handles.ind = [];    
        guidata(h1,handles);
%     end
    

    % Create a parent timer that has a function that starts each bullet's timer     
    parent_timer = timer("TimerFcn",@shootbullets,"StopFcn",@stopTime,"Period",2,"ExecutionMode","fixedRate", ...
        "TasksToExecute",10);
        
    start(parent_timer);

    function shootbullets(~,~)
        % Timer to one bullet's movement
        t_time = timer("TimerFcn",{@moveshot,h1},"StartFcn",{@shoot,h1}, "StopFcn", {@stopTime},"Period",0.1,"ExecutionMode","fixedRate", ...
             "TasksToExecute",20);
        start(t_time);
    end


    function shoot(~,~,h1)
        % Timer start function that first draws a bullet upon mouse
        % release
        
        % Load guidata and retrieve index for tower from handles
        handles = guidata(h1);
        ind = handles.ind;
    
        width = diff(tower.XData); % Width of tower image
        height = diff(tower.YData); % Height of tower image
        
        % Load guidata into handles struct
        %handles = guidata(h1);
        
        hold on        
        % Draw a bullet. Initial start position will depend on the
        % direction the chosen tower will shoot
        if attDir == "up"
            c = rectangle("Position",[tower.XData(1)+width/2,tower.YData(1),30,30],"Curvature",[1,1],"FaceColor","r");
        elseif attDir == "down"
            c = rectangle("Position",[tower.XData(1)+width/2,tower.YData(2),30,30],"Curvature",[1,1],"FaceColor","r");
        else
            c = rectangle("Position",[tower.XData(2),tower.YData(1) + height/2,30,30],"Curvature",[1,1],"FaceColor","r");
        end
        
        % Store the bullet graphics object in handles struct
        handles.rect = c;
        
        % Save guidata
        guidata(h1,handles);
    end
    
     function moveshot(~,~,h1)
        % Timer function that moves bullets across the screen 
        handles = guidata(h1);
        
        % Load the bullet graphic object created from the start function
        c = handles.rect;
        
        % Determine which direction bullet should move depending on
        % direction strategy of chosen tower
        if attDir == "up"
            % Move up the screen for 10 increments of 10
            c.Position(2) = c.Position(2) - 10;       
            drawnow;
        elseif attDir == "down"
            % Move down the screen for 10 increments of 10
            c.Position(2) = c.Position(2) + 10;
            drawnow;
        else
            % Move across the screen, to the right, for 10 increments of 10
            c.Position(1) = c.Position(1) + 10;
            drawnow;
        end
        
        % Save guidata
        handles.rectPos = c.Position;
        guidata(h1,handles);
     end
    
    function stopTime(t_time,~)
        % Stop timer function that deletes each bullet once it has moved
        % and the timer associated with each bullet        
        c = handles.rect;
        delete(c)
        delete(t_time);
    end    
end
