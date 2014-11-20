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
        %features = charactExtractor(gray_matrix); 
        features = charactExtractor2(gray_matrix);
    else
        % TODO optimize this stuff
        %features = [features; charactExtractor(gray_matrix)];
        features = [features; charactExtractor2(gray_matrix)];
    end
end

labels = textread('trainResized/trainLabels.csv', '%s', 'delimiter', ',', 'headerlines',1);
labels = labels(2 : 2 : end);

% just the unsupervized letter to try out the classifier

%record_matrix = imread('trainResized/34.Bmp');
%record_grey = charactExtractor(rgb2gray(record_matrix));
%streetview_photo = imread('testData/test.png', 'png');
%streetview_photo = imread('testData/test4.png', 'png');
%streetview_photo = imread('testData/test6.png', 'png');
streetview_photo = imread('testData/test10.png', 'png');
boxes = locate_char(streetview_photo);

%grey_street = rgb2gray(streetview_photo);

for i = 1:size(boxes,1)
   actual_box = boxes(i,:);
   % in case when width is smaller then height we assume that we have just
   % one letter found
   if actual_box(1,3) <= actual_box(1,4)
       % doing the cut from the whole photo
       cut = streetview_photo(actual_box(1,2):actual_box(1,2)+actual_box(1,4)-1, actual_box(1,1):actual_box(1,1)+actual_box(1,3)-1, :);
       % converting the letter to the grey scale
       grey_cut = rgb2gray(cut);
       % resizing the image to 20px by 20px
       resized_image = imresize(grey_cut, [20, 20]);
       % creating the record vector from the resized image
       %cut_vector = charactExtractor(resized_image);
       cut_vector = charactExtractor2(resized_image);
       % predicting the letter
       [pred, proba] = predict_knn(double(features), labels, 100, double(cut_vector));
       if proba > 13
           pred
           proba
           figure
           imshow(resized_image);
       end
   else
       for j=1:floor(actual_box(1,3)/(actual_box(1,4)))
           cut = streetview_photo(actual_box(1,2):actual_box(1,2)+actual_box(1,4)-1, (j-1)*actual_box(1,4)/2+actual_box(1,1):(j-1)*actual_box(1,4)+actual_box(1,1)+actual_box(1,4)-1, :);
           % converting the letter to the grey scale
           grey_cut = rgb2gray(cut);
           % resizing the image to 20px by 20px
           resized_image = imresize(grey_cut, [20, 20]);
           % creating the record vector from the resized image
           cut_vector = charactExtractor2(resized_image);
           % predicting the letter
           [pred, proba] = predict_knn(double(features), labels, 100, double(cut_vector));
           if proba > 13
               pred
               proba
               figure
               imshow(resized_image);
           end
      end
   end
end
