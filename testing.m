clc
clear all

%disp('30')

Dataset='C:\Users\Sneha\Desktop\imagesdatabase'
Testset='C:\test1'

width=100; height=100;
DataSet = cell([], 1);

 for i=1:length(dir(fullfile(Dataset,'*.png')))

     % Training set process
     k = dir(fullfile(Dataset,'*.png'));
     k = {k(~[k.isdir]).name};
     for j=1:length(k)
        tempImage       = imread(horzcat(Dataset,filesep,k{j}));
        imgInfo         = imfinfo(horzcat(Dataset,filesep,k{j}));
        
        if strcmp(imgInfo.ColorType,'grayscale')
            DataSet{j}   = double(imresize(tempImage,[width height])); % array of images
         else
            DataSet{j}   = double(imresize(rgb2gray(tempImage),[width height])); % array of images
         end
     end
 end
TestSet =  cell([], 1);
  for i=1:length(dir(fullfile(Testset,'*.png')))

     % Training set process
     k = dir(fullfile(Testset,'*.png'));
     k = {k(~[k.isdir]).name};
     for j=1:length(k)
        tempImage       = imread(horzcat(Testset,filesep,k{j}));
        imgInfo         = imfinfo(horzcat(Testset,filesep,k{j}));

         % Image transformation
         if strcmp(imgInfo.ColorType,'grayscale')
            TestSet{j}   = double(imresize(tempImage,[width height])); % array of images
         else
            TestSet{j}   = double(imresize(rgb2gray(tempImage),[width height])); % array of images
         end
     end
  end

train_label               = zeros(size(20,1),1);
train_label(1:10,1)   = 0;        
train_label(11:20,1)  = 1;         

% Prepare numeric matrix for svmtrain
Training_Set=[];
for i=1:length(DataSet)
    Training_Set_tmp   = reshape(DataSet{i},1, 100*100);
    Training_Set=[Training_Set;Training_Set_tmp];
end

%disp(Training_Set)

Test_Set=[];
for j=1:length(TestSet)
    Test_set_tmp   = reshape(TestSet{j},1, 100*100);
   
    Test_Set=[Test_Set;Test_set_tmp];
end

% Perform first run of svm
SVMStruct = svmtrain(Training_Set , train_label, 'kernel_function', 'linear');
Group       = svmclassify(SVMStruct, Test_Set);

disp(Group);
disp('0 stands for clean images and 1 stands for images with microaneurysm');