function output_img = scale(img, scale_size)
%Input - input_img is a two-dimensional matrices storing image
%      - scale_size is a tuple of [width, height] defining the spatial resolution of output
%Output - output_img is the same as input_img

% img = imread(input_img); %Read the data of the input picture
[h,w] = size(img); %Gets the rows and columns, the height and width of the original image

scale_w = scale_size(1); %Gets the new scaled width based on the input
scale_h = scale_size(2); %Gets the new scaled height based on the input
output_img = zeros(scale_h, scale_w); %Initialize

for i = 1 : scale_h         %The (I,j) position of the scaled image corresponds to the (x,y) of the original image.
    for j = 1 : scale_w
        x = i * h / scale_h;
        y = j * w / scale_w;
        u = x - floor(x);
        v = y - floor(y); %Take the fractional part
        
        if x < 1           %Boundary processing
            x = 1;
        end
        
        if y < 1
            y = 1;
        end
        

        %Four real pixels of the original image are used to obtain the pixel value of the "virtual" pixel by bilinear interpolation
        output_img(i, j) = img(floor(x), floor(y)) * (1-u) * (1-v) + ...
                               img(floor(x), ceil(y)) * (1-u) * v + ...
                               img(ceil(x), floor(y)) * u * (1-v) + ...
                               img(ceil(x), ceil(y)) * u * v;
    end
end

% imwrite(uint8(output_img), '../output_img.png'); %Save the processed image
imshow(img); %According to the original
figure,imshow(uint8(output_img)) %Display the processed image