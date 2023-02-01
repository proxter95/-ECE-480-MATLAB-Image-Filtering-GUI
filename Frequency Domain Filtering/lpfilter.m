function H = lpfilter(type, M, N, D0, n)
%LPFILTER Computes frequency domain lowpass filter transfer functions.
% 
%   H = LPFILTER(TYPE, M, N, D0, n) generates the transfer function, H, of a
%   lowpass filter of the specified type and size (MxN).
% 
%   Valid values for TYPE, D0, and n are:
%         
%      'ideal'       Ideal lowpass filter transfer function with cutoff
%                    frequency D0. n is not needed. D0 must be positive.
% 
%      'butterworth' Butterworth lowpass filter transfer function of order
%                    n with cutoff frequency D0. The default value for n is
%                    1.0. D0 must be positive.
% 
%      'gaussian'    Gaussian lowpass filter transfer function with cutoff
%                    frequency (standard deviation) D0. n is not needed. D0
%                    must be positive

[U, V] = dftuv(M, N); %Set up meshgrid

D = hypot(U, V); %Compute distances D(U,V)

%Compute Transfer Functions
switch type
    case 'ideal'
        H = double(D <= D0);
    case 'butterworth'
        if nargin == 4
            n = 1;
        end
        H = 1./(1 + (D./D0).^(2*n));
    case 'gaussian'
        H = exp(-(D.^2)./(2*(D0^2)));
    otherwise
        error('Unknown Filter Type')
end