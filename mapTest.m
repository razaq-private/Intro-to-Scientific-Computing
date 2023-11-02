map = imread('bloonsMap.png');
editedMap = imread('editedBloonsMap.png');
mapPath = editedMap.*(map~=editedMap);
imshow(mapPath)