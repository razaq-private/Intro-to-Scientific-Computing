function out = pd024116(p1_hist, p2_hist)
    B = ~isnan(p2_hist);    
    % indices: 
    Indices = arrayfun(@(x) find(B(:, x), 1, 'last'), 1:size(p2_hist, 2));
    % values:
    prevPlay = arrayfun(@(x,y) p2_hist(x,y), Indices, 1:size(p2_hist, 2));

    if prevPlay == 0
        out = 0;
    else 
        out = 1;
    end
end