x = 0:0.1:10;
y = 0.5*x;
plot(x,y)
axis manual

map_axis = gca;
set(map_axis,'xtick',[])
set(map_axis,'ytick',[])
set(map_axis,'Box','on')
xlim([0,10])
ylim([0,5])

h = hgtransform('Parent',map_axis);
hold on
plot(x(1),y(1),'o','Parent',h);
hold off

for k = 2:length(x)
    m = makehgtform('translate',x(k)-x(1),y(k)-y(1),0);
    h.Matrix = m;
    drawnow
end