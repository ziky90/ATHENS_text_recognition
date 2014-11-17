clear all;
clean all;

% here parametrize the path to the input image database
A = imread('trainResized/14.Bmp', 'bmp')

% TODO 1) iterate over whole folder -> perform turning to black and white ->
% flatten and feed the classifier (do other feature extraction from image stuff, append features)

% save the learned model

% load the classifier
% o the sliding window + it's scalling => feature extraction + prediction
% from  model