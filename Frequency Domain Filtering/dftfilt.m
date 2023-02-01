function g = dftfilt(f, H, padMethod)
%DFTFILT Performs frequency domain filtering.
%   g = DFTFILT(f, H, padMethod) filters f in the frequncy domain using the
%   filter transform function H. The output, g, is the filtered image of
%   the same size as f. g is of type double.

%   padMethod Values:
%   'zeros'     Pads the imput image with 0s using the 'post' option in
%               padarray function. Default. 
%   'symmetric' Pads the imput image using the 'symmetric' and 'post' 
%               options in the padarray function.
%   'replicate' Pads the imput image using the 'replicate' and 'post' 
%               options in the padarray function.
%   'circular'  Pads the imput image using the 'circular' and 'post' 
%               options in the padarray function.

if (nargin < 3) || isempty(padMethod) || isequal(padMethod, 'zeros')
    padMethod = 0;
end

isRGB = ndims(f) == 3;
if isRGB
    f = rgb2lab(f);
    I = f(:,:,1);
else
    I = f;
end

I = im2double(I); %Convert input to floating point.
M = size(I);

Ip = padarray(I, [size(H,1) - M(1), size(H,2) - M(2)], padMethod, 'post');
F = fft2(Ip); %Compute FFT

%Folowing 2 lines apply the filter and produce the output image g.
G = H.*F;
g = ifft2(G); 

g = g(1:M(1), 1:M(2)); %Crop output to original size.
g = abs(g);

if isRGB
    f(:,:,1) = g;        
    g = lab2rgb(f);
end

end