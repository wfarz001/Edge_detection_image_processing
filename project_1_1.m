I=imread('5.2.09.tiff'); %Read in image
Ics=imadjust(I,stretchlim(I, [0.08 0.95]),[]); %Stretch contrast using method 1
figure;
%sgtitle('Constrast [Amax=0.95,Amin=0.05] Enhanced Image')
subplot(2,2,1), imshow(I); title ('Original Image')%Display image
subplot(2,2,2), imshow(Ics);title('Constrast Stretched Image')% Contrast Enhanced Image
subplot(2,2,3), imhist(I); title('Histogram of Original Image')%Display input histogram
subplot(2,2,4), imhist(Ics);title('Histogram of Contrast Image') %Display output histogram

sgtitle('Constrast [Amax=0.95,Amin=0.08] Enhanced Image')

%%%%%%     Appling Gamma Transform  %%%%%%%%%

figure;
subplot(2,2,1), imshow(I); title('Original Image') %Display image
Id= im2double(I);
Output1=2*(Id.^0.5);
Output2=2*(Id.^1.5);
Output3=2*(Id.^3.0);
subplot(2,2,2), imshow(Output1);  title('Gamma=0.5,Constarst Image')                            %Display result images
subplot(2,2,3), imshow(Output2);  title('Gamma=1.5, Constrast Image')
subplot(2,2,4), imshow(Output3);  title('Gamma=3.0, Constrast Image')

sgtitle(' Constrast Enhanced Image using Gamma Transform')