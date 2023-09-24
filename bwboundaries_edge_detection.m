s = load('clown.mat')
% Display it as an indexed, pseudocolored image.
%imshow(s.X, s.map);
% Create and display the RGB image.
rgbImage = ind2rgb(s.X, s.map);
rgbImage=imresize(rgbImage,[256,256]); %%% Resizing the original Image to 256X256
figure;
subplot(2,2,1),imshow(rgbImage);
title('Original Image')

Ib= rgb2gray(rgbImage);
subplot(2,2,2),imshow(Ib);
title('Gray Image')

I=imbinarize(Ib);
subplot(2,2,3),imshow(I);
title('Binary Image')

[B,L] = bwboundaries(I, 8);  %reference:https://blogs.mathworks.com/pick/2021/02/09/tracing-the-boundary-of-a-binary-region-in-an-image/
Contour2 = false(size(L));
for ii = 1:numel(B)
    thisB = B{ii};
    inds = sub2ind(size(L), thisB(:, 1), thisB(:, 2));
    Contour2(inds) = 1;
end

subplot(2,2,4), imshow(Contour2)
title('Using bwboundaries function')

fcn = @() bwboundaries(I, 8);
t_IPT = timeit(fcn);
fprintf('Time Required Using Boundary Function: %0.5f sec\n', t_IPT)
