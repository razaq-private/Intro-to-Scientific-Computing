% create instructions for how the user should play
function instructions(h1,~,annotationsFig,g5,balloonImage)
    % retrieve the GUI data
    handles = guidata(h1);
    set(annotationsFig,'visible','on');
    set(g5,'visible','on');
    
    % instructions for how points work
    dim1 = [.025 .6 .3 .3];
    str1 = 'Accumulate points by popping balloons';
    text1 = annotation('textbox',dim1,'String',str1,'FitBoxToText','on','BackgroundColor','w');

    % instructions for how the bananas work
    dim2 = [.025 .525 .3 .3];
    str2 = 'Use bananas to buy more monkeys to pop balloons';
    str2 = [str2 newline 'Bananas populate automatically'];
    text2 = annotation('textbox',dim2,'String',str2,'FitBoxToText','on','BackgroundColor','w');
    
    % instructions for balloons
    dim3 = [.025 .4 .3 .3];
    str3 = 'Balloons automatically move along the map';
    str3 = [str3 newline 'When they hit the end of the path, the health decreases'];
    text3 = annotation('textbox',dim3,'String',str3,'FitBoxToText','on','BackgroundColor','w');
    
    % instructions for tower
    dim4 = [.025 .2 .3 .3];
    str4 = 'Place towers by dragging and dropping them onto the map to pop balloons';
    str4 = [str4 newline 'Each tower has 20 bullets and will automatically start shooting'];
    str4 = [str4 newline 'Each tower costs 3000 bananas and will decrease the banana count when placed'];
    str4 = [str4 newline 'The pink and blue towers shoot up. The superhero monkey shoots down.'];
    text4 = annotation('textbox',dim4,'String',str4,'FitBoxToText','on','BackgroundColor','w');
    
    % instructions for tower
    dim5 = [.025 0 .3 .3];
    str5 = 'Once you are done reading, close the figure window and press start';
    str5 = [str5 newline 'Have fun and good luck!'];
    text5 = annotation('textbox',dim5,'String',str5,'FitBoxToText','on','BackgroundColor','w');

end