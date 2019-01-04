clc;
close all;
clear all;
warning off all;
image=imread('C:\Users\Sneha\Downloads\diaretdb1_v_1_1\diaretdb1_v_1_1\resources\images\ddb1_fundusimages\image027.png')

i = image(:,:,2);
figure,imshow(i);title('green channel image');

[m n] = size(i);
j1 = adapthisteq(i);
figure,imshow(j1);title('CLAHE');

se1 = strel('disk',2);
%figure, imshow(se1); title('Vessel Enhancement')
ic1 = imclose(j1,se1);
figure,imshow(ic1);title('removal of vessel central light reflex 1')

 if1 = imfill(ic1,'holes');
figure,imshow(if1);title('removal of vessel central light reflex 2')

inImg=if1;

% inImg = im;
% dim = ndims(inImg);
% if(dim == 3)
%     %Input is a color image
%     inImg = rgb2gray(inImg);
% end

%Extract Blood Vessels
Threshold = 10;
bloodVessels = VesselExtract(inImg, Threshold);

%Output Blood Vessels image

%figure;
%imshow(inImg);title('Input Image');

figure;
imshow(bloodVessels);title('Extracted Blood Vessels');

disp(bloodVessels)

% train_label               = zeros(size(30,1),1);
% train_label(1:44,1)   = 1;         % 1 = Airplanes
% train_label(45:89,1)  = 2;         % 2 = Faces
% 
% labels=train_label;
% pcaPar=1;
% Acc=[];Conf=[];
% 
%  Err=[];
%         K=10;
%         indices = crossvalind('Kfold',labels,K);
%         cp = classperf(labels);
%         for i = 1:K
%             test = (indices == i); train = ~test;
%             [trainSet, prin]=PCA(feat(train,:),pcaPar);
%             testSet=feat(test,:)*prin;
%             [class, err] = classifySVM(testSet,trainSet,labels(train,:),'linear',f, i);
%             Err=[Err;err];
%             classperf(cp,class,test);
%         end
%         Acc=[Acc (1-cp.ErrorRate)*100];
%         Conf=[Conf;mean(Err)];
%     
%     Grid=[Grid;Acc];
%     Confidences=[Confidences;(Conf)];
%     pcaPar=pcaPar-0.05;
