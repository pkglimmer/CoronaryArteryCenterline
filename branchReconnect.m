function sk1 = branchReconnect(sk, img_prop, costThresh, angleThresh)
    CC = bwconncomp(sk);
    L = labelmatrix(CC);
    kernel = ones(3,3,3);
    kernel(2,2,2) = 100;
    edpt = convn(kernel, sk); % endpoint detection 
    edpt = (edpt==101);
    edpt = edpt(2:size(edpt,1)-1, 2:size(edpt,2)-1, 2:size(edpt,3)-1);
    [r, c, v] = ind2sub(size(edpt), find(edpt));
    endpoints = [r, c, v];
    % Use dijkstra's shortest path algorithm
    %   on a 3D image grid to generate a weighted 
    %   distance field from a source voxel. Vertices are 
    %   voxels and edges are the 26 nearest neighbors 
    %   (except for the edges of the image where 
    %   the number of edges is reduced).
    sk1 = sk;
    MAX_DIST = 25;
    for i = 1:length(r)
        vertex = endpoints(i, :);
        label = L(vertex(1), vertex(2), vertex(3));
        ROI = L(max(vertex(1)-MAX_DIST, 1):min(vertex(1)+MAX_DIST, size(L,1)), ...
            max(vertex(2)-MAX_DIST, 1):min(vertex(2)+MAX_DIST, size(L, 2)), ...
            max(vertex(3)-MAX_DIST, 1):min(vertex(3)+MAX_DIST, size(L, 3)));
        weight = 1-double(img_prop(max(vertex(1)-MAX_DIST, 1):min(vertex(1)+MAX_DIST, size(L,1)), ...
            max(vertex(2)-MAX_DIST, 1):min(vertex(2)+MAX_DIST, size(L, 2)), ...
            max(vertex(3)-MAX_DIST, 1):min(vertex(3)+MAX_DIST, size(L, 3))))/65536;
        [temp1, temp2, temp3] = ind2sub(size(ROI), find(ROI & ROI~=label));
        % find the closest point of current endpoint
        POI = [temp1, temp2, temp3];
        if isempty(POI)
            continue
        end
        x0 = MAX_DIST + 1;
        y0 = MAX_DIST + 1;
        z0 = MAX_DIST + 1;
        if vertex(1)<MAX_DIST
            x0 = vertex(1);
        end
        if vertex(2)<MAX_DIST 
            y0 = vertex(2); 
        end
        if vertex(3)<MAX_DIST
            z0 = vertex(3);
        end
        source = [x0, y0, z0];
        distance = sum((POI-source).^2, 2);
        [~, closest] = min(distance);
        target = POI(closest, :); % target coordinate
        % Use included angles to validate. Calculate local directions of: 
        % 1.endpoint 2.target point  3. line connecting them
        if vertex(1)<2 || vertex(1)>size(sk,1)-2 || ...
            vertex(2)<2 || vertex(2)>size(sk,2)-2 || ...
            vertex(3)<2 || vertex(3)>size(sk,3)-2 
            continue
        end
        roi = sk(vertex(1)-1:vertex(1)+1, vertex(2)-1:vertex(2)+1, vertex(3)-1:vertex(3)+1);
        roi(2,2,2)=0;
        [temp1, temp2, temp3]=ind2sub(size(roi), find(roi,1));
        dirVec1 = [2,2,2] - [temp1, temp2, temp3]; % endpoint direction
        targetLocale = [max(vertex(1)-MAX_DIST, 1)+target(1)-1, ...
            max(vertex(2)-MAX_DIST, 1)+target(2)-1, max(vertex(3)-MAX_DIST, 1)+target(3)-1];
        if targetLocale(1)<2 || targetLocale(1)>size(sk,1)-2 || ...
            targetLocale(2)<2 || targetLocale(2)>size(sk,2)-2 || ...
            targetLocale(3)<2 || targetLocale(3)>size(sk,3)-2 
            continue
        end
        roi = sk(targetLocale(1)-1:targetLocale(1)+1, targetLocale(2)-1:targetLocale(2)+1, targetLocale(3)-1:targetLocale(3)+1);
        roi(2,2,2)=0;
        [temp1, temp2, temp3]=ind2sub(size(roi), find(roi,1));
        dirVec2 = [2,2,2] - [temp1, temp2, temp3]; % 
        dirVec3 = targetLocale - vertex;
        %angle1 = 180 / pi * acos( dirVec1*dirVec2'/sqrt(sum(dirVec1.^2)*sum(dirVec2.^2)));
        angle2 = 180 / pi * acos( dirVec1*dirVec3'/sqrt(sum(dirVec1.^2)*sum(dirVec3.^2)));

        [subROI, source, target, idx] = getSubregion(ROI, source, target);
        [path, cost] = DijkstraConnect(subROI, weight, source, target);
        avgCost = cost/size(path, 1);
        if avgCost>costThresh && angle2>angleThresh
            continue
        end
        for k= 1:size(path, 1)
            subROI(path(k,1), path(k,2), path(k,3)) = 1;
        end
        ROI(idx(1):idx(2), idx(3):idx(4),idx(5):idx(6)) = subROI;
        sk1(max(vertex(1)-MAX_DIST, 1):min(vertex(1)+MAX_DIST, size(L,1)), ...
            max(vertex(2)-MAX_DIST, 1):min(vertex(2)+MAX_DIST, size(L, 2)), ...
            max(vertex(3)-MAX_DIST, 1):min(vertex(3)+MAX_DIST, size(L, 3))) = ROI;
    end
end