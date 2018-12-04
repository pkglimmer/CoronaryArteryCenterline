function vesselShow(ROI, ROI1)
% 3-D binarized matrix visualization
    [r, c, v] = ind2sub(size(ROI), find(ROI));
    vessel = {[r, c, v]};
    color_trip = jet(length(vessel));
    % plot coronary artery tree
    figure;
    ax1 = subplot(1,2,1);
    for ii = 1:length(vessel)
        plot3(vessel{ii}(:, 1), ...
              vessel{ii}(:, 2), ...
              vessel{ii}(:, 3), ...
              '.', 'Color', color_trip(ii, :));
        hold on;
    end
    
    [r, c, v] = ind2sub(size(ROI1), find(ROI1));
    vessel1 = {[r, c, v]};
    color_trip = jet(length(vessel1));
    % plot coronary artery tree
    ax2 = subplot(1,2,2);
    for ii = 1:length(vessel1)
        plot3(vessel1{ii}(:, 1), ...
              vessel1{ii}(:, 2), ...
              vessel1{ii}(:, 3), ...
              '.', 'Color', color_trip(ii, :)); 
        hold on;
    end
    Link = linkprop([ax1,ax2],{'CameraPosition','CameraUpVector',...
        'CameraTarget', 'XLim', 'YLim', 'ZLim'}); 
    setappdata(gcf, 'StoreTheLink', Link);
    rotate3d on
end
