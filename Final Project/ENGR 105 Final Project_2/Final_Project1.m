% create a set of axes as the "map"
map_axis = axes;
axis image              % ensure that the x and y scales are equal on the resulting image
xlim([0,7])             % x limits
ylim([-2,2])            % y limits
set(map_axis,'xtick',[])  % turn off x tick marks
set(map_axis,'ytick',[])  % turn off y tick marks
set(map_axis,'Box','on')

set(gcf,'visible');
hold on

% make the map image the background
map_image = imread('bloonsMap.png');
map_back = image(xlim,-ylim,map_image); 
uistack(map_back,'bottom')

% create an object to move
pos = [0 1.5];
balloon = rectangle('Position',[pos .2 .2],'Curvature',[1,1],'FaceColor','r')

% make the map and balloons into a graphics object
map = gca
h = hgtransform('Parent',map)
hold on

m = makehgtform('translate',0);
h.Matrix = m;
drawnow

gameGoing = 0;
% as long as the game is going, the balloons will move
while gameGoing < 50
    
    for k = 1:25
        
        % Create vector determining particle step
        d_k = 0.1;

        % Update particle position;
        pos = pos + d_k;

        % Ensure particle doesn't move out of bounds
        pos = max(min(pos,6),0);

        % Update visualization
        balloon.Position(1) = pos(1);

        % Pause MATLAB
        pause(0.1)

        % make a function to check this condition later!!
        gameGoing = gameGoing +1;
    end
    
end