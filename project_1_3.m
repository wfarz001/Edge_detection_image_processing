% Load clown image data.
s = load('clown.mat')
% Display it as an indexed, pseudocolored image.
%imshow(s.X, s.map);
% Create and display the RGB image.
rgbImage = ind2rgb(s.X, s.map);
rgbImage=imresize(rgbImage,[256,256]); %%% Resizing the original Image to 256X256
figure;
subplot(2,2,1),imshow(rgbImage);
title('Original Image')

%%%Selecting Sub-Image from the original Image%%%%%

fun = @(block_struct) imresize(block_struct.data,0.125);%% To take a block of 32X32 , multiply the image with (1/8=0.125)
I2 = blockproc(rgbImage,[32 32],fun); %% reference :https://www.mathworks.com/help/images/ref/blockproc.html

subplot(2,2,2), imshow(I2);
title('Sub Image of size 32X32')

%%%%Image Thresholding %%%%%%%%%%%%%

I= rgb2gray(rgbImage)
level=graythresh(I); %Get OTSU threshold
It=im2bw(I, level); %Threshold image
subplot(2,2,3),imshow(It);
title('OSTU Thresholded Image')




BW = imbinarize(I);
subplot(2,2,4),imshow(BW);
title('Binary Image using imbinarize')
%figure
%imshowpair(I,BW,'montage')

BW1 = edge(BW,'log'); % reference:https://www.mathworks.com/help/images/ref/edge.html
BW2 = edge(BW,'Sobel');
BW3= edge(BW,'Prewitt');
bw4= edge(BW,'Roberts');
figure;
subplot (2,2,1),imshow(BW1); title('Edge Detection Using Log Method')
subplot (2,2,2),imshow(BW1); title('Edge Detection Using Sobel Method')
subplot (2,2,3),imshow(BW1); title('Edge Detection Using Prewitt Method')
subplot (2,2,4),imshow(BW1); title('Edge Detection Using Roberts Method')

fcn_log = @() edge(BW,'log');
fcn_sobel = @() edge(BW,'sobel');
fcn_prewitt = @() edge(BW,'Prewitt');
fcn_Roberts = @() edge(BW,'Roberts');
t_log=timeit(fcn_log)
t_sobel=timeit(fcn_sobel)
t_prewitt=timeit(fcn_prewitt)
t_roberts=timeit(fcn_Roberts)
fprintf('Time taken by log method:%0.5f sec\n',t_log)
fprintf('Time taken by Sobel method:%0.5f sec\n',t_sobel)
fprintf('Time taken by Prewitt method:%0.5f sec\n',t_prewitt)
fprintf('Time taken by Roberts method:%0.5f sec\n',t_roberts)
