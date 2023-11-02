boundaryRec = rectangle('Position',[0 9.5 10 1], 'LineWidth', 3)

greenRec = rectangle('Position',[0 9.5 10 1], 'FaceColor', 'green')

for k = 1:0.5:10+1
    redRec = rectangle('Position',[0 9.5 k 1], 'FaceColor', 'red')
    pause(0.1)
end  