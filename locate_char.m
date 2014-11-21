function box = locate_char (test)

%test = (imread('test7.png'));

edgeMask = edge(rgb2gray(test), 'Canny',0.3);
edgeMask = bwmorph(edgeMask,'spur');

se = strel('square',3);
dilated = imdilate(edgeMask,se);

filled = imfill(dilated,'holes');
%imshow(filled);
[labels] = bwlabel(filled);

stats = regionprops(labels);
box = [stats.BoundingBox];
box = reshape(box,[4 length(box)/4])';
num = length(box);

m=1;
while m < num
    if box(m,3) > 0.25*size(test,2) || box(m,4)>0.25*size(test,1) || box(m,3) < 15 || box(m,4)<15
        box(m,:) = [];
        m=m-1;
    end
    num = length(box);
    m=m+1;
end

figure
imshow(test);
hold on;
for cnt = 1:size(box,1)
    rectangle('position',box(cnt,:),'edgecolor','r');
end
hold off
end
