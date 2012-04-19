## This is an example of image segmentation using
## fishers method to find the threshold of an image
## in gray levels.
## 
## Author: Bruno Normande Lins (aka. Jollyrog3r)

clear all;
close all;

ImageChocolat = double(imread('Chocolat.jpg'));
[Nlin, Ncol] = size(ImageChocolat);
## Printing the original image
figure(); 
imshow(uint8(ImageChocolat));
title("Original Image");
axis('image');

## transform the image into a array so we can take its histogram
ImageArray = zeros(1, Nlin*Ncol);
k = 1;
for lin=1:Nlin
  for col = 1:Ncol
    ImageArray(k) = ImageChocolat(lin,col);
    k = k+1;
  end
end
## Histogram normalized from the images 256 gray levels
Hist = hist(ImageArray,256)/ (size(ImageArray)(2));

## Plotting the histogram
figure(); 
plot(Hist);
title("Histogram");

## gets the threshold which divides the histogram in 2 segments
## using fisher method - the magic happens here ;D
Threshold = Fisher(Hist);

## Now, lets create the binary image
BinaryImage = zeros(Nlin, Ncol);
## puts '1' where the pixel of ImageChocolat grays lvl is lower than
## the threshold found
BinaryImage(ImageChocolat < Threshold) = 1;

##  and voilà
figure();
imshow(BinaryImage);
title("After segmentation fisher method");


