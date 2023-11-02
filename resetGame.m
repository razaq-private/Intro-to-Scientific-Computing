function gameStatus = resetGame(h1,~,x1,x2,x3,x4,x5,x6,dmg,bndHth,Hth,vec1,vec2,vec3,button,f1,f2,f3)
    % x1 = redStartPos
    % x2 = redBalloonStep
    % x3 = blueStartPos
    % x4 = blueBalloonStep
    % x5 = greenStartPos
    % x6 = greenBalloonStep
    % dmg = damage
    % vec1 = redBalloon Vec
    % vec2 = blueBalloonVec
    % vec3 = greenBalloonVec
    % f1 = makeBalloon Func
    % f2 = moveBalloon Func
    % f3 = healthBar Func
    
    % retrieve the GUI data
    
    handles = guidata(h1);
    hballoonObj = handles.balloonObj;
    
    numR = 20;
    numB = 20;
    numG = 10;
    
    vec1 = f1(h1,numR,'redBalloon.png',1);
    vec2 = f1(h1,numB,'blueBalloon.png',2);
    vec3 = f1(h1,numG,'greenBalloon.png',3);
    hold off
    
    xlim([0,1450])
    ylim([0,670])
    
    bndHth = rectangle('Position',[900 15 500 20], 'LineWidth', 3);
    Hth = rectangle('Position',[900 15 500 20], 'FaceColor', 'green');
    dmg = rectangle('Position', [900 15 0 20], 'FaceColor', 'red');

    gameStatus = true;
    
    x1 = zeros(1,length(x1));
    x2 = zeros(1,length(x2));
    x3 = zeros(1,length(x3));
    x4 = zeros(1,length(x4));
    x5 = zeros(1,length(x5));
    x6 = zeros(1,length(x6));
    
    disp('oo it worked')
    
    numActiveBal = 1:numR+numB+numG;
    
    set(button,'Visible','off')
    while gameStatus
        % move the red balloons
        [x2,x1] = f2(h1,vec1,x2,x1,0,1);
        % move the blue balloons
        [x4,x3] = f2(h1,vec2,x4,x3,numR,2);
        %move the green balloons
        [x6,x5] = f2(h1,vec3,x6,x5,numR+numB,3);
        % check the health bar
        [gameStatus,dmg,numActiveBal] = f3(h1,dmg,numActiveBal,gameStatus);
        if ~gameStatus
            set(button,'Visible','on')
        end    
        
    end
end