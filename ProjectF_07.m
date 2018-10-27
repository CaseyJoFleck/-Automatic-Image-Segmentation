function [BW] = ProjectF_07(I)
bw1 = imbinarize(I,'adaptive','ForegroundPolarity','dark','Sensitivity',0.48); %converting gray-scale image into black and white image
bw1 = imcomplement(bw1);    %complementing image to filter noise in image
k = bwmorph(bw1, 'clean');  %cleaning noise of image
BWao = bwareaopen(k,40);    %further filtering noise of image and creating smoother lines
[L, num] = bwlabel(BWao);    %classifying the shapes in the image
for i = 1:num %for-loop that runs through shape of each image
    r = L == i;             
     aSum = find(L == i); %finds the shape in each image
     if numel(aSum) <= 5000 %set shape to black if its area is less than a certain value
           BWao(r) = 0; 
     end
end
y = bwareaopen(BWao,40); %using filter bwareaopen to further clean the image of noise
y = bwmorph(y, 'spur'); %smooth lines in image

y = imclose(imopen(y, ones(3,3)), ones(3,3)); %using morphological operations imclose and imopen to smooth lines and clean noise
y = imcomplement(y);            %complementing image again
BW = bwmorph(y,'spur');         %smoothing lines in image and setting BW to logical image
