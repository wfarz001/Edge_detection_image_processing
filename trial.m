% Load clown image data.
s = load('clown.mat')
% Display it as an indexed, pseudocolored image.
%imshow(s.X, s.map);
% Create and display the RGB image.
rgbImage = ind2rgb(s.X, s.map);

sz = 25;
Image = rgb2gray(rgbImage)

binaryImage = imbinarize(Image);
binaryImage = imfill(binaryImage,'holes');
binaryImage = bwareaopen(binaryImage, 100);
binaryImage = padarray(binaryImage,60,60,'both')
binaryImage = imcomplement(binaryImage);
 
imshow(binaryImage);
axis on;
hold on; 
 
boundaries = bwboundaries(binaryImage);
 
%%%%%%%% Extract chain code
for k = 1 : length(boundaries)
    % Get the k'th boundary.
    thisBoundary = boundaries{k};
    % Get the x and y coordinates.
    x = thisBoundary(:, 2);
    y = thisBoundary(:, 1);
    % Plot this boundary over the original image.
    hold on;
    plot(x, y, 'g-', 'LineWidth', 2);
    scatter(x(1,1), y(1,1),sz, 'filled') % Mark starting point
    % Create the chain code.
    for p = 2 : length(y)
        % See where the current point is relative to the prior point.
        if x(p) < x(p-1) && y(p) < y(p-1)
            % Moved to the upper left
            thisChainCode(p) = 1;
        elseif x(p) == x(p-1) && y(p) < y(p-1)
            % Moved straight up
            thisChainCode(p) = 2;
        elseif x(p) > x(p-1) && y(p) < y(p-1)
            % Moved to the upper right
            thisChainCode(p) = 3;
        elseif x(p) > x(p-1) && y(p) == y(p-1)
            % Moved right
            thisChainCode(p) = 4;
        elseif x(p) > x(p-1) && y(p) > y(p-1)
            % Moved right and down.
            thisChainCode(p) = 5;
        elseif x(p) == x(p-1) && y(p) > y(p-1)
            % Moved down
            thisChainCode(p) = 6;
        elseif x(p) <= x(p-1) && y(p) > y(p-1)
            % Moved down and left
            thisChainCode(p) = 7;
        elseif x(p) <= x(p-1) && y(p) == y(p-1)
            % Moved left
            thisChainCode(p) = 8;
        end
    end
    % Save the chain code that we built up for this boundary
    % into the cell array that will contain all chain codes.
    chainCodes{k} = thisChainCode
end

%%%%%%%% Plot chain code
%celldisp(chainCodes);
cc=num2str(cell2mat(chainCodes));
cc(cc == ' ') = []
c = 'b';
x = zeros(strlength(cc)+1,1); %Consider storing values and pre-allocating to save time
y = zeros(strlength(cc)+1,1); 
x(1) = 100;
y(1) = 50;
 
figure %Creates a blank figure object
for i = 1 : strlength(cc)
    switch str2double(cc(i)) %Switches are faster than if/elseif with this many options
        case {0 8} %Assumes 0 and 8 are the same case
            x(i+1) = x(i)+1;
            y(i+1) = y(i);
        case 1
            x(i+1) = x(i)+1;
            y(i+1) = y(i)+1;
        case 2
            x(i+1) = x(i);
            y(i+1) = y(i)+1;
        case 3
            x(i+1) = x(i)-1;
            y(i+1) = y(i)+1;
            case 4
            x(i+1) = x(i)-1;
            y(i+1) = y(i);
        case 5
            x(i+1) = x(i)-1;
            y(i+1) = y(i)-1;
        case 6
            x(i+1) = x(i);
            y(i+1) = y(i)-1;
        case 7
            x(i+1) = x(i)+1;
            y(i+1) = y(i)-1;
        otherwise
            error('Invalid')
    end
end
%One plot for efficiency
scatter(-x+max(x),-y+max(y),sz,c,'filled');
axis ij;
axis tight;
daspect([1 1 1]);