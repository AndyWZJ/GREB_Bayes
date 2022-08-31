function output_img = scale(img, scale_size)
%Input - input_img is a two-dimensional matrices storing image
%      - scale_size is a tuple of [width, height] defining the spatial resolution of output
%Output - output_img is the same as input_img

% img = imread(input_img); %Read the data of the input picture
[h,w] = size(img); %Get line and column, that is, the height and width of the original picture

scale_w = scale_size(1); %According to the input, the new width after the zoom is obtained
scale_h = scale_size(2); %Based on the new height after the input obtained zoom
output_img = zeros(scale_h, scale_w); %initialization

for i = 1 : scale_h         %The position of the (i, j) position after zooming corresponds to the original image (x, y)
    for j = 1 : scale_w
        x = i * h / scale_h;
        y = j * w / scale_w;
        u = x - floor(x);
        v = y - floor(y); %Taking the decimal part
        
        if x < 1           %Border treatment
            x = 1;
        end
        
        if y < 1
            y = 1;
        end
        

        %Use the four real pixels of the original picture to get dual -linear interpolation to obtain the pixel value of the "virtual" pixel
        output_img(i, j) = img(floor(x), floor(y)) * (1-u) * (1-v) + ...
                               img(floor(x), ceil(y)) * (1-u) * v + ...
                               img(ceil(x), floor(y)) * u * (1-v) + ...
                               img(ceil(x), ceil(y)) * u * v;
    end
end

% imwrite(uint8(output_img), '../output_img.png'); %Save the processing image
imshow(img); %Display the original map
figure,imshow(uint8(output_img)) %Display the image after processing