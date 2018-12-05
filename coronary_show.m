function [] = coronary_show(coro_tree)
% This function loads existing coronary artery tree 'coro_tree', and plot 
% it in different color according to the ids of branches. Before sorting,
% the order of points in each branch is unknown, thus a scatter plot is
% needed.
% 
% Examples
%   coronary_show(coro_tree)

% create a color map
color_trip = jet(length(coro_tree));

% plot coronary artery tree
figure;
for ii = 1:length(coro_tree)
    plot3(coro_tree{ii}(:, 1), ...
          coro_tree{ii}(:, 2), ...
          coro_tree{ii}(:, 3), ...
          '-', 'Color', color_trip(ii, :)); % '.'(before sorting) or '-'(after sorting)
    hold on;
    rotate3d on;
end

end

