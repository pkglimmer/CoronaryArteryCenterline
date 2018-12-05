function vesselShow(ROI, ROI1)
% 3-D binarized matrix visualization
% Input: 3D matrices or cells. If nargin==2, the panel handles two volumes
% with *linkprop* so that the directions change simultaneously.
    if nargin == 1
        figure;
        vesselPlot3(ROI);
        rotate3d on
        return
    end
    figure;
    ax1 = subplot(1,2,1);
    vesselPlot3(ROI);
    ax2 = subplot(1,2,2);
    vesselPlot3(ROI1);
    Link = linkprop([ax1,ax2],{'CameraPosition','CameraUpVector',...
        'CameraTarget', 'XLim', 'YLim', 'ZLim'}); 
    setappdata(gcf, 'StoreTheLink', Link);
    rotate3d on
end

function vesselPlot3(ROI)
    if isequal(class(ROI), 'logical')
        [r, c, v] = ind2sub(size(ROI), find(ROI));
        plot3(r, c, v, '.');
            hold on;
    else
        color_trip = jet(length(ROI));
        for ii = 1:length(ROI)
            plot3(ROI{ii}(:, 1), ROI{ii}(:, 2), ROI{ii}(:, 3), '-', 'Color', color_trip(ii, :));
            hold on;
        end 
    end
end
