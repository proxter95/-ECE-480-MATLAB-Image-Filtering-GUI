function [r, F, S] = imnoise3(M, N, C, A, B)
%IMNOISE3 2-D sinusiodal pattern.
%   [r, F, S] = IMNOISE3(M,N,C,A,B), generates a spatial sinusoial pattern,
%   r, of size MxN, and its Fourier Transform, F, and Spectrum, S.
% 
%   The input parameters C, A, and B, are as follows:
% 
%   C is a Kx2 matrix each row of which contains the frequency domain
%   coordinates, (u,v), for one of K impulses. The conjugate of each
%   impulse is generated automatically. The coordinates are integers in
%   units of frequency with respect to the center of the MxN frequency
%   rectangle. Therefore, u and v determine the number of cycles of the
%   sine wave along the u- and v-axis for each impulse. 
% 
%   A is a 1xK vector containing the amplitude of each of the K impulse
%   pairs. If A is not included in the argument it defaults to 1 for each
%   impulse. B is then automatically set to 0. To include B and use the
%   default values for A, include A as the empty matrix, [], in the input.
% 
%   B is a Kx2 matrix containt the Bx and By phase components for each
%   impulse pair. The values can be positive or negative floating point
%   numbers. Positive values cause displacement of the sine wave in the
%   direction of the positive axis, and conversely for negative values. The
%   default value for B is zeros(K,2).

K = size(C, 1);

if nargin == 3
    A = ones(1,K);
    B = zeros(K,2);
elseif nargin == 4 && isempty(A)
    B = zeros(K,2);
end

ucenter = floor(M/2) + 1;
vcenter = floor(N/2) + 1;

F = zeros(M,N);
for k = 1:K
    u1 = ucenter + C(k,1);
    v1 = vcenter + C(k,2);

    u2 = ucenter - C(k,1);
    v2 = vcenter - C(k,2);

    F(u1, v1) = 1i*M*N*(A(k)/2)*exp(-1i*2*pi*(u1*B(k,1))/M + v1*B(k,2)/N);
    F(u2, v2) = -1i*M*N*(A(k)/2)*exp(1i*2*pi*(u2*B(k,1))/M + v2*B(k,2)/N);
end

S = abs(F);
r = real(ifft2(ifftshift(F)));

end
