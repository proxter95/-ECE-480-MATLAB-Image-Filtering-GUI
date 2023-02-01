function H = bandfilter(type, band, M, N, C0, W, n)
%BANDFILTER Computes filter frequency domain band filter transfer
%functions.
%   H = BANDFILTER('ideal', BAND, M, N, C0, W) computes an MxN ideal
%   bandpass or bandreject filter transfer function, depending on the value
%   of BAND.
% 
%   H = BANDFILTER('butterworth', BAND, M, N, C0, W, n) computes an MxN
%   butterworth transfer function of order n. The function is either 
%   bandpass or bandreject depending on the value of BAND. Default value of
%   n is 1.
% 
%   H = BANDFILTER('gaussian', BAND, M, N, C0, W) computes an MxN
%   gaussian transfer function of order n. The function is either 
%   bandpass or bandreject depending on the value of BAND.
%
%   Valid values of BAND areL
%       'reject'    Bandreject filter transfer function.
%       'pass'      Bandpass filter transfer function.
%
%   The other parameters are as follows:
% 
%        M: Number of rows in teh transfer function.
%        N: Number of columns in the transfer function.
%       C0: Radius of the center of the band.
%        W: "Width" of the band. True width of the ideal transfer function 
%           only. For the others, it acts like a smooth cutoff. 
%        n: Order of the butterworth transfer function.
% 
%   H is of class double. 

[U, V] = dftuv(M, N); %Set up meshgrid

D = hypot(U, V); %Compute distances D(U,V)

if nargin < 7
    n = 1; %set n = 1 by default
end

%compute transfer functions
switch type
    case 'ideal'
        H = idealReject(D, C0, W);
    case 'butterworth'
        H = butterworthReject(D, C0, W, n);
    case 'gaussian'
        H = gaussReject(D, C0, W);
    otherwise
        error('Unknown filter type.')
end

% Convert to badpass if specified.
if isequal(band, 'pass')
    H = 1 - H;
end

    function H = idealReject(D, C0, W)
        RI = D <= C0 - (W/2);
        RO = D >= C0 + (W/2);

        H = im2double(RO | RI);
    end

    function H = butterworthReject(D, C0, W, n)
        H = 1./(1 + ((D*W)./(D.^2 - C0^2)).^(2*n));
    end

    function H = gaussReject(D, C0, W)
        H = 1 - exp(-((D.^2 - C0^2)./(D.*W + eps)).^2);
    end

end