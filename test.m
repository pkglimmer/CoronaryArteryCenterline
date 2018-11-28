%img_path = fullfile(rpath, img_list(ii).name);
img_path = '/Users/peikunguo/Documents/2018_Fall/数图/homework/project2/ours_066_c1.mha';
[img_prop, img_info] = mha_read_volume(img_path);

%% thresholdingCoro
img_bin = img_prop >= (0.2*intmax('uint16'));
% check the binary image obtained by considering it as a volume data,
% and you can also store the binary volume into a single file (.mha file)

% volumeViewer(img_bin);
w_info = img_info; % header information of volume to be written
w_info.DataType = 'uchar'; % change the data type to uchar (uint8)
mha_write(img_bin, w_info, './coro_bi.mat'); 

%% filling holes ( open )
img_bin = imfill(img_bin, 'holes');

%% Open
se = strel('sphere', 1);
fe = imerode(img_bin, se);
imgOpen = imdilate(fe, se);
volumeViewer(imgOpen)

%%
sk = bwskel(img_bin);
volumeViewer(sk);


