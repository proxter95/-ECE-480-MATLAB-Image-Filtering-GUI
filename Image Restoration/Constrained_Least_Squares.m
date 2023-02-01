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

NOISEPOWER = 0;
[frest, ~] = deconvreg(blurred_noisy, PSF, NOISEPOWER);

figure
imshow(frest); title("Recostructed with NOISEPOWER = " + NOISEPOWER)

NOISEPOWER = var*numel(f);
[frest2, ~] = deconvreg(blurred_noisy, PSF, NOISEPOWER);

figure
imshow(frest2); title("Recostructed with NOISEPOWER = " + NOISEPOWER)

[frest3, ~] = deconvreg(blurred_noisy, PSF, 0.85*NOISEPOWER);

figure
imshow(frest3); title("Recostructed with NOISEPOWER = " + 0.85*NOISEPOWER)


