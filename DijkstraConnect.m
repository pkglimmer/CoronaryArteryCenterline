function [path, cost] = DijkstraConnect(ROI, weight, source, target)
% connects two given points in the given region of interest using
% Dijkstra's shortest path algorithm.
% ROI: 3D logical matrix with source and target inside
% weight: matrix of weight, same size as ROI (e.g. subregion of original .mha file)
% source, target: coordinates of the 2 points to be connected
% path: vector containing coordinates on the path with minimun cost
% cost: total cost along the path
    [l, w, h] = size(ROI);
    weight = weight(:)'; % flatten
    s = [];
    t = [];
    weights = [];
    for j = 1:h-1
        s = [s, (1:(l*w))+l*w*(j-1)];
        t = [t, (1:(l*w))+l*w*j];
        weights = [weights, weight((1:(l*w))+l*w*j)];
    end
    s0 = (repmat(1:l,h,1)+((0:h-1)*(l*w))')';
    for j = 1:w-1
        s = [s, s0(:)'+l*(j-1)];
        t = [t, s0(:)'+l*j];
        weights = [weights, weight(s0(:)'+l*j)];
    end
    s0 = (repmat((0:w-1)*l,h,1)+((0:h-1)*(w*l))'+1)';
    for j = 1:l-1
        s = [s, s0(:)'+(j-1)];
        t = [t, s0(:)'+j];
        weights = [weights, weight(s0(:)'+j)];
    end
    % Dijkstra
    G = graph(s, t, weights);
    source_ = l*w*(source(3)-1) + l*(source(2)-1) + source(1);
    target_ = l*w*(target(3)-1) + l*(target(2)-1) + target(1);
    [path, cost] = shortestpath(G, source_, target_);
    % retrieve path as 3-D point series
    path = path';
    row = mod(path, l);
    row(~row) = l; % mod(_,l) result could be 0, but should be l
    col = ceil(mod(path, l*w)/l);
    col(~col) = w;
    height = ceil(path/(l*w));
    path = [row col height];
end