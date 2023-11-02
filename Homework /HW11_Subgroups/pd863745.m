
function out = pd863745(p1_hist, ~)
    
    z = p1_hist.*(p1_hist == 1); 
    % Returns p1_history only when it returns value of 1
    % This makes the length of vector z equal to the number of times p1
    % cooperated.
    if length(z) > 0.5*length(p1_hist)
        % if p1 has cooperated for more than half of the past turns
        out = 1; % cooperate. Professionals have standards.
        
    elseif length(z) == 0.5*length(p1_hist)
        out = randi([0,1]); % randomly choose to be hostile or cooperative
        
    else % (if p1 has cooperated for less than half the past turns, 
         % meaning that they are mostly hostile)
        out = 0; % also act hostile to minimize risk of spending 
                 % more years in jail
    end
end
