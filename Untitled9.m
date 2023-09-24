s = load('clown.mat')
% Display it as an indexed, pseudocolored image.
%imshow(s.X, s.map);
% Create and display the RGB image.
rgbImage = ind2rgb(s.X, s.map);
%rgbImage=imresize(rgbImage,[256,256]); %%% Resizing the original Image to 256X256
figure;
imshow(rgbImage);

I=rgb2gray(rgbImage);
I = imbinarize(I);
I=imresize(I,[256,256]);
figure;
imshow(I);

fun = @(block_struct) imresize(block_struct.data,0.125);%% To take a block of 32X32 , multiply the image with (1/8=0.125)
I2 = blockproc(I,[32 32],fun); %% reference :https://www.mathworks.com/help/images/ref/blockproc.html
figure;
imshow(I2);
title('Sub Image of size 32X32')

[Code, row_idx0, col_idx0] = Freeman_chain_code(I2, true);