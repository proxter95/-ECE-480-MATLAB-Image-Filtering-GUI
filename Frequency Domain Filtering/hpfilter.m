function H = hpfilter(type, M, N, D0, n)
%HPFILTER Computes frequency domain lowpass filter transfer functions.
% 
%   H = HPFILTER(TYPE, M, N, D0, n) generates the transfer function, H, of a
%   lowpass filter of the specified type and size (MxN).
% 
%   Valid values for TYPE, D0, and n are:
%         
%      'ideal'       Ideal highpass filter transfer function with cutoff
%                    frequency D0. n is not needed. D0 must be positive.
% 
%      'butterworth' Butterworth highpass filter transfer function of order
%                    n with cutoff frequency D0. The default value for n is
%                    1.0. D0 must be positive.
% 
%      'gaussian'    Gaussian highpass filter transfer function with cutoff
%                    frequency (standard deviation) D0. n is not needed. D0
%                    must be positive
%   
%   The transfer function of a highpass filter is 1 minus the transfer 
%   function of the corresponding lowpass filter and can be written as
%
%                               Hhp = 1 - Hlp
%   
%   where Hhp is the highpass transform and Hlp is the lowpass transform.
%   Thus, the lpfilter function can be used to generate highpass filters.

if nargin == 4 %set n = 1 by default
    n = 1;
end

H = 1 - lpfilter(type, M, N, D0, n);

end