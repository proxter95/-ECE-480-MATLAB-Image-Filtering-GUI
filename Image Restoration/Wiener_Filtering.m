close all
clear
clc

f = imread('chronometer-small.tif');
f = im2double(f);
len = 50;
theta = 45;

PSF = fspecial('motion', len, theta);
blurred = imfilter(f, PSF, 'conv', 'circular');

% figure
% imshow(blurred)

mean = 0.0;
var = 0.0001;
blurred_noisy = imnoise(blurred, 'gaussian', mean, var);
noise = blurred_noisy - blurred;

figure
imshow(blurred_noisy); title('Blurred and Noisy')

Sn = abs(fft2(noise)).^2;       % Noise Power Spectrum
nA = sum(Sn(:))/numel(noise);   % Noise Avg. Power
Sf = abs(fft2(f)).^2;           % Image Power Spectrum
fA = sum(Sf(:))/numel(noise);   % Image Avg. Power

R = nA/fA; % NSPR

frest = deconvwnr(blurred_noisy, PSF, R);

figure
imshow(frest); title('Restored using NSPR')

%Autocorrelation for noise and image, respectively
NCORR = fftshift(ifft2(Sn));
ICORR = fftshift(ifft2(Sf));

frest2 = deconvwnr(blurred_noisy, PSF, NCORR, ICORR);

figure
imshow(frest2); title('Restored using Autocorrelation')




