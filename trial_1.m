% Load clown image data.
s = load('clown.mat')
% Display it as an indexed, pseudocolored image.
%imshow(s.X, s.map);
% Create and display the RGB image.
rgbImage = ind2rgb(s.X, s.map);
%rgbImage=imresize(rgbImage,[256,256]);
subplot (2,2,1),imshow(rgbImage);title('Original Image')
%imwrite(rgbImage,'myclown.png')

I= rgb2gray(rgbImage);
I = imbinarize(I);
subplot (2,2,2),imshow(I);title('Binary Image')

%C = imcontour(I, 1);
C=~bwperim(I);
subplot(2,2,3), imshow(C); title('Image Contour using bwperim function')
%[y,x] = find(C== 0);


[cc] = chaincode(C,true) %reference:https://www.mathworks.com/matlabcentral/fileexchange/29518-freeman-chain-code

fcn = @()chaincode(C,true);
t_IPT = timeit(fcn);
fprintf('Time Required Using Chain Function: %0.5f sec\n', t_IPT)
T = struct2table(cc,'AsArray',true)
k=cell2table(T.code)
writecell(k.Var1,'C_tab.txt','Delimiter','tab')
type 'C_tab.txt'