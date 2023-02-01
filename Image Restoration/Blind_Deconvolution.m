close all
clear
clc

f = imread('chronometer-small-blurred-noisy.tif');
f = im2double(f);
imshow(f); title('Blurry Image')

PSFE1 = ones(11)/11^2;
f1 = deconvblind(f,PSFE1, 50);

figure
imshow(f1); title('Blind Restoration Ver. 1')

sig = 11/6;
PSFE2 = fspecial('gaussian', 11, sig^2);
f2 = deconvblind(f, PSFE2, 50);

figure
imshow(f2); title('Blind Restoration Ver. 2')

PSFE3 = fspecial('gaussian', 13, 4);
f3 = deconvblind(f, PSFE3, 50);

figure
imshow(f3); title('Blind Restoration Ver. 3')







