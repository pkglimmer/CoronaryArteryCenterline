function vesselShow(ROI)
% 3-D binarized matrix visualization
    [r, c, v] = ind2sub(size(ROI), find(ROI));
    vessel = {[r, c, v]};
    coronary_show(vessel)
end