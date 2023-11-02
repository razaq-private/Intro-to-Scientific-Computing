function pointCounter(h1,hedit)
    % retrieve the GUI data
    handles = guidata(h1);

        handles.points = handles.points + 1;
        % update the bananas textbox with the score
        hedit.String = handles.points;
    
    % save the gui data
    guidata(h1,handles);
end
