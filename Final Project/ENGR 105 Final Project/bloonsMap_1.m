map = imread('bloonsMap.png');
imshow(map)
hold on
rect1 = rectangle('Position', [0 0 5 6], 'EdgeColor', 'r', 'LineWidth', 3)
axis equal
hold off
%imshow(map)
% greyMap = map(:,:,2);
% imshow(greyMap)
% 
% B = ones(5);
% B = B/sum(B,'all');
% filteredMap = filter2(B, greyMap);
% BW_Map = filteredMap > 150;
% imshow(BW_Map)
% [L, num] = bwlabel(BW_Map);