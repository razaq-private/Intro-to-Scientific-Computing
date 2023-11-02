function moveTower(h1,~,towerBank)
    % Mouse motion callback. Moves the marker centerpoint    
    % held in x/y index 'ind' if 'ind' is not an empty set.   
    % Updates visuals accordingly.
    
    handles = guidata(h1);    
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
         drawnow;
     end
end