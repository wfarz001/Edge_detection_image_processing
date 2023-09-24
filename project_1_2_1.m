
%%%%Image Interpolation without using imresize function%%%%%%%
A=imread('rice.png');
% DEFINE THE RESAMPLE SIZE
Col = 512;
Row = 512;
%FIND THE RATIO OF THE NEW SIZE BY OLD SIZE
rtR = Row/size(A,1);
rtC = Col/size(A,2);

%OBTAIN THE INTERPOLATED POSITIONS
IR = ceil([1:(size(A,1)*rtR)]./(rtR));
IC = ceil([1:(size(A,2)*rtC)]./(rtC));

%ROW_WISE INTERPOLATION
B = A(:,IR);

%COLUMN-WISE INTERPOLATION
B = B(IC,:);


figure,subplot(121),imshow(A);title('BEFORE INTERPOLATION'); axis([0,512,0,512]);axis on;

subplot(122),imshow(B);title('AFTER INTERPOLATION');  axis([0,512,0,512]);axis on;

figure;
scale=1/32;
[W,H,D]=size(B);
w=W*scale;h=H*scale;
shrink_imdata=imresize(B,[w,h]);
subplot (1,2,1);
imshow(B);
str=[{'Original image ' [num2str(W) , 'Pixel X' num2str(H) 'Pixel']}];
title(str);
subplot (1,2,2);
imshow(shrink_imdata);
str=[{'Size reduced image ' [num2str(w) 'Pixel X' num2str(h) 'Pixel']}];
title(str);

figure;
zoom_nearest = imresize(shrink_imdata, [W,H], 'nearest');
[W1,H1]=size(zoom_nearest);
subplot (2,2,1);
imshow(zoom_nearest);
%str=[{'Zoomed image with nearest neighbour interpolation'}];
title('Zoomed image with nearest neighbour interpolation');

zoom_bilinear = imresize(shrink_imdata,[W,H],'bilinear');
[W2,H2]=size(zoom_bilinear);
subplot (2,2,2);
imshow(zoom_bilinear);
%str=[{'Zoomed image with bilinear interpolation'}];
title('Zoomed image with bilinear interpolation');


zoom_bicubic = imresize(shrink_imdata,[W,H],'bicubic');
[W3,H3]=size(zoom_bicubic);
subplot (2,2,3);
imshow(zoom_bilinear);
%str=[{'Zoomed image with bicubic interpolation'}];
title('Zoomed image with bicubic interpolation');

switch D
    case 3
MSE_image_vs_nearest=(sum(sum((B(:,:,1)-zoom_nearest(:,:,1)).^2+(B(:,:,2)-zoom_nearest(:,:,2)).^2+(B(:,:,3)-zoom_nearest(:,:,3)).^2)))./(W*H);
MSE_image_vs_bilinear=sum(sum((B(:,:,1)-zoom_bilinear(:,:,1)).^2+(B(:,:,2)-zoom_bilinear(:,:,2)).^2+(B(:,:,3)-zoom_bilinear(:,:,3)).^2))./(W*H);
MSE_image_vs_bicubic=sum(sum((B(:,:,1)-zoom_bicubic(:,:,1)).^2+(B(:,:,3)-zoom_bicubic(:,:,3)).^2+(B(:,:,3)-zoom_bicubic(:,:,3)).^2))./(W*H);
    case 1
MSE_image_vs_nearest=sum(sum((B(:,:,1)-zoom_nearest(:,:,1)).^2))./(W*H);
MSE_image_vs_bilinear=sum(sum((B(:,:,1)-zoom_bilinear(:,:,1)).^2))./(W*H);
MSE_image_vs_bicubic=sum(sum((B(:,:,1)-zoom_bicubic(:,:,1)).^2))./(W*H);
end
T = table(MSE_image_vs_nearest,MSE_image_vs_bilinear,MSE_image_vs_bicubic)