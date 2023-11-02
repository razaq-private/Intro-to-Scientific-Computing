function bananaCounter(h1,hedit)
    % retrieve the GUI data
    handles = guidata(h1);
    handles.bananas = handles.bananas + 1;
    
    % only update the text string for whole numbers
    if mod(handles.bananas,10) == 0
        % update the bananas textbox with the score
        hedit.String = handles.bananas;
    end
    
    % save the gui data
    guidata(h1,handles);
end
