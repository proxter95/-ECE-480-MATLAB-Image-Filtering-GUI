close all
clear
clc

f = imread('chronometer-small.tif');
f = im2double(f);
len = 50;
theta = 45;

PSF = fspecial('motion', len, theta);
blurred = imfilter(f, PSF, 'conv', 'circular');

mean = 0.0;
var = 0.0001;
blurred_noisy = imnoise(blurred, 'gaussian', mean, var);
noise = blurred_noisy - blurred;

figure
imshow(blurred_noisy); title('Blurred and Noisy')

frest1 = deconvlucy(blurred_noisy, PSF);

figure
imshow(frest1)

frest2 = deconvlucy(blurred_noisy, PSF, 75);

figure
imshow(frest2)

DAMPAR = 0.5*sqrt(var);
frest3 = deconvlucy(blurred_noisy, PSF, 150, DAMPAR);

figure
imshow(frest3)

