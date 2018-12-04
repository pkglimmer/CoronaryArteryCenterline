function [subROI, source, target, idx] = getSubregion(ROI, s, t)
    temp = (s-t>0);
    m = abs(s(1)-t(1))+1;
    n = abs(s(2)-t(2))+1;
    o = abs(s(3)-t(3))+1;
    if isequal(temp, [0,0,0])
        subROI = ROI(s(1):t(1), s(2):t(2), s(3):t(3));
        source = [1,1,1];
        target = [m,n,o];
        idx = [s(1),t(1), s(2),t(2), s(3),t(3)];
    elseif isequal(temp, [0,0,1])
        subROI = ROI(s(1):t(1), s(2):t(2), t(3):s(3));
        source = [1,1,o];
        target = [m,n,1];
        idx = [s(1),t(1), s(2),t(2), t(3),s(3)];
    elseif isequal(temp, [0,1,0])
        subROI = ROI(s(1):t(1), t(2):s(2), s(3):t(3));
        source = [1,n,1];
        target = [m,1,o];
        idx = [s(1),t(1), t(2),s(2), s(3),t(3)];
    elseif isequal(temp, [0,1,1])
        subROI = ROI(s(1):t(1), t(2):s(2), t(3):s(3));
        source = [1,n,o];
        target = [m,1,1];
        idx = [s(1),t(1), t(2),s(2), t(3),s(3)];
    elseif isequal(temp, [1,0,0])
        subROI = ROI(t(1):s(1), s(2):t(2), s(3):t(3));
        source = [m,1,1];
        target = [1,n,o];
        idx = [t(1),s(1), s(2),t(2), s(3),t(3)];
    elseif isequal(temp, [1,0,1])
        subROI = ROI(t(1):s(1), s(2):t(2), t(3):s(3));
        source = [m,1,o];
        target = [1,n,1];
        idx = [t(1),s(1), s(2),t(2), t(3),s(3)];
    elseif isequal(temp, [1,1,0])
        subROI = ROI(t(1):s(1), t(2):s(2), s(3):t(3));
        source = [m,n,1];
        target = [1,1,o];
        idx = [t(1),s(1), t(2),s(2), s(3),t(3)];
    elseif isequal(temp, [1,1,1])
        subROI = ROI(t(1):s(1), t(2):s(2), t(3):s(3));
        source = [m,n,o];
        target = [1,1,1];
        idx = [t(1),s(1), t(2),s(2), t(3),s(3)];
    end
end
