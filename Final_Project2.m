% create a set of axes as the "map"
map_axis = axes;
axis image              % ensure that the x and y scales are equal on the resulting image
xlim([0,7])             % x limits
ylim([-2,2])            % y limits
%set(map_axis,'xtick',[])  % turn off x tick marks
%set(map_axis,'ytick',[])  % turn off y tick marks
set(map_axis,'Box','on')

set(gcf,'visible');
hold on

% make the map image the background
map_image = imread('bloonsMap.png');
map_back = image(xlim,-ylim,map_image); 
uistack(map_back,'bottom')

x = 0:0.1:3;
y = piecewise(0<x<1.75, 1.4,1.75 <= x<3 , 1);
plot(x,y,'w')
hold on
p = plot(x(1),y(1),'o','MarkerFaceColor','red');
hold off

for k = 2:length(x)
    p.XData = x(k);
    drawnow
end