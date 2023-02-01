function [S, S1] = showfftplots(f, H, padMethod)
%SHOWFFTPLOTS Dislays 2 plots: 1 with the fft of an image, and the other 
% with the Transfer function applied to the fft.
%   [S, S1] = SHOWFFTPLOTS(F, H, option) generates 2 plots that show the 
%   fft of an image as well as the fft with the filter transfer function 
%   applied. F is the input image and H is its corresponding transfer 
%   function. First, the input image is padded to the size of the filter 
%   transfer function. Then the fft is calculated, centered and scaled 
%   using the mat2gray function. A log transform filter is also applied. 
%   Then the transfer function is centered and combined with the fft using 
%   element-wise multiplication. Both results are then plotted on seperate 
%   figures with corresponding titles.
% 
%   padMethod Values:
%   'zeros'     Pads the imput image with 0s using the 'post' option in
%               padarray function. Default. 
%   'symmetric' Pads the imput image using the 'symmetric' and 'post' 
%               options in the padarray function.
%   'replicate' Pads the imput image using the 'replicate' and 'post' 
%               options in the padarray function.
%   'circular'  Pads the imput image using the 'circular' and 'post' 
%               options in the padarray function.

if nargin < 2
    error('Not enough imput arguments.')
end

if (nargin < 3) || isempty(padMethod) || isequal(padMethod, 'zeros')
    padMethod = 0;
end

close all

fp = padarray(f, [size(H,1) - size(f,1), size(H,2) - size(f,2)], padMethod, 'post');

%generate fft and center it.
F = fft2(fp);
Fc = fftshift(F);

%intnesity scaling
S = mat2gray(1 + log(abs(Fc)));

%shift trasfer function and apply it to fft
Hc = fftshift(H);
S1 = (Hc.*S);

%plot
figure
imshow(S); title('Image FFT')
figure
imshow(S1); title('FFT with Transfer Function')

end