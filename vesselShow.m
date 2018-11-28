function vesselShow(ROI)
    [r, c, v] = ind2sub(size(ROI),find(ROI));
    vessel = {[r, c, v]};
    coronary_show(vessel)
end