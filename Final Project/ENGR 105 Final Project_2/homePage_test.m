homePage = true;
h1 = figure('Visible','on');

% create data structure to store info about interface
handles = struct;

% initialize the field that will be inputed
handles.balloonObj = [];
% 'ind' will be used to track the index of the marker that is to be moved when a mouse movement is detected. 
% An empty set indicates that no index has been selected.
handles.ind = [];
% initialize the number of bananas
handles.bananas = 0;
% initialize the number of bananas
handles.points = 0;

% store data structure as GUI data
guidata(h1,handles);

% create axes for home page
g3 = axes('units','normalized','position',[0,0,1,1],'Visible','on');

% turn tick marks off
set(gca,'xtick',[]);
set(gca,'ytick',[]);

startButton = uicontrol('Style','pushbutton','Units','Normalized','Position',...
         [0.2,0.4,0.2,0.2],'String','Start');
helpButton = uicontrol('Style','pushbutton','Units','Normalized','Position',...
         [0.6,0.4,0.2,0.2],'String','Help');
  
homePage = true;

startButton.Callback = {@startGame,h1,homePage,startButton,helpButton};