function out = pd778551(p2_hist,p1_hist)
    % start by playing uncooperatively
    out = 0;
    % if they play majority uncooperatively, continue to play that way as
    % well
    if length(p2_hist)*0.9 > sum(p2_hist)
        out = 0;
       % only play cooperatively if you both normally defect or if they
       % usually cooperate and I usually dont
    elseif length(p2_hist)/2 > sum(p2_hist) && length(p1_hist)/2 > sum(p1_hist) || length(p2_hist)/2 > sum(p2_hist) && length(p1_hist)/2 < sum(p1_hist) 
        out = 1;
    end
end