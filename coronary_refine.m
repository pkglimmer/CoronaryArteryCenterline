function [] = coronary_refine( rpath )
% This function processes each probability map of coronary arteries under
% 'rpath'. The processing steps include but not limited to thresholding, 
% filling holes, thinning, detecting bifurcation or end points, 
% reconnecting disconnected branches, removing isolated branches, and 
% obtains a coronary artery tree finally.
% 
% Examples:
%   coronary_refine('path_of_parent_directory_containg_volumes')

% create output directory
wpath = fullfile(rpath, 'coronary');
if ~exist(wpath, 'dir'), mkdir(wpath); end

% processing each volume under rpath
img_list = dir(fullfile(rpath, '*.mha'));
for ii = 1:length(img_list)
    %% read mha volume
    img_path = fullfile(rpath, img_list(ii).name);
    [img_prop, img_info] = mha_read_volume(img_path);
    
    %% thresholdingCoro
    img_bin = img_prop >= (0.5*intmax('uint16'));
    % check the binary image obtained by considering it as a volume data,
    % and you can also store the binary volume into a single file (.mha file)
    volumeViewer(img_bin);
    w_info = img_info; % header information of volume to be written
    w_info.DataType = 'uchar'; % change the data type to uchar (uint8)
    mha_write(img_bin, w_info, 'path'); 
    
    %% filling holes
    % your code here ...

    %% thinning
    % your code here ...
    % 
    % plot the centerline of coronary artery by considering it as a set of
    % points, e.g. denote 'img_thin' as the result of thinning step
    [cpt_x, cpt_y, cpt_z] = ind2sub(size(img_thin), find(img_thin));
    plot3(cpt_x, cpt_y, cpt_z, '.r');
    
    %% detecting bifurcation and end points
    % your code here ...
    
    %% reconnecting disconnected branches & removing isolate points or branches
    % your code here ...
    
    %% obtain coronary artery tree (by tracking or other methods)
    % your code here ...
    % 
    % plot the complete coronary artery tree in different color according 
    % to the ids of branches, e.g. denote 'coro_tree', a cell array, as the 
    % coronary artery tree obtained, and each element is a coordinate array
    % of a single branch
    coronary_show(coro_tree);
    
    %% save the tree obtained into a mat file (.mat)
    coro_tree{1} = rand(10, 3); % for example, branch 1
    coro_tree{2} = rand(12, 3); % for example, branch 2 ...
    tree_name = split(img_list(ii).name, '.');
    tree_name = [tree_name{1}, '.mat'];
    tree_path = fullfile(wpath, tree_name);
    save(tree_path, 'coro_tree');
end

end
