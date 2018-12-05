% This script simplifies the procedure of connecting two points in a 
% 3-D space using linear interpolation
BW = rand([50 50 50])>.25; % your 3d matrix
i1 = [3, 2, 20];           % coordinates of initial point
i2 = [6, 10, 25];          % coordinates of end point
n = max(abs(i2-i1))+1;     % number of steps
i = arrayfun(@(a,b)round(linspace(a,b,n)),i1,i2,'uni',0);
idx = sub2ind(size(BW),i{:});
sumBW = nnz(BW(idx)); % number of non-zero elements
disp(cell2mat(i'));        % display trajectory
disp(sumBW);               % display number of 1's in path