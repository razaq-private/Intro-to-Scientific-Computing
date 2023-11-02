% create a set of axes as the "map"
g1 = axes;
axis image          %Setting this ensure that the x and y scales are equal on the resulting image
xlim([0,7])         % x limits
ylim([-2,2])        % y limits
set(g1,'xtick',[])  % turn off x tick marks
set(g1,'ytick',[])  % turn off y tick marks
set(g1,'Box','on')

set(gcf,'visible');
hold on

% make the map image the background
map_image = imread('bloonsMap.png');
map = image(xlim,-ylim,map_image); 
uistack(map,'bottom')

% create an object to move
balloon = rectangle('Position',[0 1.5 .2 .2],'Curvature',[1,1],'FaceColor','r')
pos = [0 1.5];

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