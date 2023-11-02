function pickTower(h1,~,towerBank)
     % Mouse button down callback. Determines if the mouse was    
     % clicked within the limits of a marker and, if so, takes    
     % control of the marker.
     
     handles = guidata(h1);
     
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
            handles.selected = 1;
      end
      
      guidata(h1,handles);
end