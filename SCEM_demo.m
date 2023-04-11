clear;
close all
addpath(genpath(pwd))
%% load dataset
% dataset#1 to #5, where dataset#1-#5 are used in the paper.
dataset = '#1'; % #1 to #5
opt.normlized = 'on';
Load_dataset % For other datasets, we recommend a similar pre-processing as in "Load_dataset"
h = fspecial('average',5);
image_t1 = imfilter(image_t1, h,'symmetric');
image_t2 = imfilter(image_t2, h,'symmetric');
fprintf(['\n Data loading is completed...... ' '\n'])
%% Parameter setting
par.Ns = 5000;
par.Niter = 20;
par.alpha = 0.01;
par.beta = 0.5;
par.lambda = 4;
%% SCEM
fprintf(['\n SCEM is running...... ' '\n'])
par.fuse = 'off';
[p1,Cosup,~] = SCEM_main(image_t1,image_t2,par);
DI1  = suplabel2DI(Cosup,p1');

par.fuse = 'on';
time = clock;
[p2 ,Cosup,Rel_diff] = SCEM_main(image_t1,image_t2,par);
clc
fprintf('\n');fprintf('The total computational time of SCEM is %i \n',etime(clock,time));
DI2  = suplabel2DI(Cosup,p2');
figure;subplot(121);imshow(remove_outlier(DI1),[]);title('²îÒìÍ¼1')
subplot(122);imshow(remove_outlier(DI2),[]);title('²îÒìÍ¼2')
