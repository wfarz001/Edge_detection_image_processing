s = load('clown.mat')
% Display it as an indexed, pseudocolored image.
%imshow(s.X, s.map);
% Create and display the RGB image.
rgbImage = ind2rgb(s.X, s.map);
rgbImage=imresize(rgbImage,[256,256]); %%% Resizing the original Image to 256X256
figure;
imshow(rgbImage);
title('Original Image')

I= rgb2gray(rgbImage);
I=imbinarize(I);
figure;
imshow(I);
title('Binary Image')

[B,L] = bwboundaries(I, 8);
Contour2 = false(size(L));
for ii = 1:numel(B)
    thisB = B{ii};
    inds = sub2ind(size(L), thisB(:, 1), thisB(:, 2));
    Contour2(inds) = 1;
end
figure
imshow(Contour2)
title('Using bwboundaries')