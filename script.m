clear all;
close all;


% for over all the images in the training dataset
features = [];
for i = 1:6283      % 6283
    %strcat('trainResized/', num2str(i), '.Bmp')
    img_matrix = imread(strcat('trainResized/', num2str(i), '.Bmp'), 'bmp');
    if size(img_matrix,3) == 1
        gray_matrix = img_matrix;
    else
        gray_matrix = rgb2gray(img_matrix);
    end
    if isempty(features)
        features = charactExtractor(gray_matrix);
    else
        % TODO optimize this stuff
        features = [features; charactExtractor(gray_matrix)];
    end
end

labels = textread('trainResized/trainLabels.csv', '%s', 'delimiter', ',', 'headerlines',1);
labels = labels(2 : 2 : end);

% just the unsupervized letter to try out the classifier
record_matrix = imread('trainResized/34.Bmp');
record_grey = charactExtractor(rgb2gray(record_matrix));
predict_knn(double(features), labels, 100, double(record_grey)) % 5 is just a random guess

% build theclassifier !!!

% save the learned model

% load the classifier
% o the sliding window + it's scalling => feature extraction + prediction
% from  model