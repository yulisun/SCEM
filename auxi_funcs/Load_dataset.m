if strcmp(dataset,'#1') == 1 % Heterogeneous CD of multispectral VS. multispectral
    image_t1 = imread('Italy_1.bmp');
    image_t2 = imread('Italy_2.bmp');
    gt = imread('Italy_gt.bmp');
    opt.type_t1 = 'optical';
    opt.type_t2 = 'optical';
elseif strcmp(dataset,'#2') == 1 % Heterogeneous CD of multispectral VS. multispectral
    image_t1 = imread('Img7-Bc.tif');
    image_t2 = imread('Img7-Ac.tif');
    gt = imread('Img7-C.tif');
    opt.type_t1 = 'optical';
    opt.type_t2 = 'optical';
elseif strcmp(dataset,'#3') == 1 % Heterogeneous CD of SAR VS. Optical
    image_t1 = imread('shuguang_1.bmp');
    image_t2 = imread('shuguang_2.bmp');
    gt = imread('shuguang_gt.bmp');
    opt.type_t1 = 'sar';
    opt.type_t2 = 'optical';
elseif strcmp(dataset,'#4') == 1 % Heterogeneous CD of SAR VS. Optical
    image_t1 = imread('YellowRiver_1.jpg');
    image_t2 = imread('YellowRiver_2.jpg');
    gt = imread('YellowRiver_gt.bmp');
    opt.type_t1 = 'sar';
    opt.type_t2 = 'optical';
elseif strcmp(dataset,'#5') == 1 %Heterogeneous CD of Optical VS. SAR
    image_t1 = imread('Img5-Bc.tif');
    image_t2 = imread('Img5-A.tif');
    gt = imread('Img5-C.tif');
    opt.type_t1 = 'optical';
    opt.type_t2 = 'sar';
end
Ref_gt = double(gt(:,:,1));
%% plot images
figure;
subplot(131);imshow(image_t1);title('image t1')
subplot(132);imshow(image_t2);title('image t2')
subplot(133);imshow(Ref_gt,[]);title('Refgt')
%%
image_t1 = double(image_t1);
image_t2 = double(image_t2);
if strcmp(opt.normlized,'on') == 1
    image_t1 = image_normlized(image_t1,opt.type_t1);
    image_t2 = image_normlized(image_t2,opt.type_t2);
end
Ref_gt = Ref_gt/max(Ref_gt(:));
