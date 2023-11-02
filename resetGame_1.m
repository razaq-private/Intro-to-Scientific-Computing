function gameStatus = resetGame(~,~,h1,x1,x2,x3,x4,dmg,bndHth,Hth,vec1,vec2,button,f1,f2,f3)
    % x1 = redStartPos
    % x2 = redBalloonStep
    % x3 = blueStartPos
    % x4 = blueBalloonStep
    % x5 = damage
    % vec1 = redBalloon Vec
    % vec2 = blueBalloonVec
    % f1 = makeBalloon Func
    % f2 = moveBalloon Func
    % f3 = healthBar Func
    
    % retrieve the GUI data
    
    handles = guidata(h1);
    hballoonObj = handles.balloonObj;
    vec1 = f1(h1,10,'redBalloon.png',1);
    vec2 = f1(h1,10,'blueBalloon.png',2);
    hold off
    
    xlim([0,1450])
    ylim([0,670])
    bndHth = rectangle('Position',[900 15 500 20], 'LineWidth', 3);
    Hth = rectangle('Position',[900 15 500 20], 'FaceColor', 'green');
    dmg = rectangle('Position', [900 15 0 20], 'FaceColor', 'red');

    x1 = zeros(1,length(x1));
    x2 = zeros(1,length(x2));
    x3 = zeros(1,length(x3));
    x4 = zeros(1,length(x4));
    disp('oo it worked')
    
    gameStatus = true;
    
    while gameStatus
        % move the red balloons
        [x2,x1] = f2(h1,vec1,x2,x1,0,1);
        % move the blue balloons
        [x4,x3] = f2(h1,vec2,x4,x3,10,2);
        % check the health bar
        [gameStatus,dmg] = f3(h1,dmg,gameStatus);
    end
end