function f = spfilt(g, type, varargin)
%SPFILT Performs linear and nonlinear spatial filtering.
%   F = SPFILT(G, TYPE, VARARGIN) performs spatial filtering of image G
%   using a TYPE filter of size mxn. The output image F is of class double.
%   Valid calls to SPFILT are as follows:
% 
%       F = SPFILT(G, 'amean', m, n)        Arithmetic mean filtering.
%       F = SPFILT(G, 'gmean', m, n)        Geometric mean filtering.
%       F = SPFILT(G, 'hmean', m, n)        Harmonic mean filtering.
%       F = SPFILT(G, 'chmean', m, n, Q)    Contraharmonic mean filtering
%                                           of order Q. The default value 
%                                           of Q is 1.5.
%       F = SPFILT(G, 'median', m, n)       Median filtering.
%       F = SPFILT(G, 'max', m, n)          Max filtering.
%       F = SPFILT(G, 'min', m, n)          Min filtering.
%       F = SPFILT(G, 'midpoint', m, n)     Midpoint filtering.
%       F = SPFILT(G, 'atrimmed', m, N, n)  Alpha-trimmed mean filtering.
%                                           Parameter D must be a 
%                                           nonnegative even integer; its 
%                                           default values is 2.
% 
%   The default values when only G and TYPE are input are m = n = 3, Q =
%   1.5, and D = 2.

[m,n,Q,d] = parseInputs(varargin{:});

switch type
    case 'amean'
        w = fspecial('average', [m,n]);
        f = imfilter(g,w,'replicate');
    case 'gmean'
        f = gmean(g,m,n);
    case 'hmean'
        f = harmean(g,m,n);
    case 'chmean'
        f = charmean(g,m,n,Q);
    case 'median'
        f = medfilt2(g, [m n], 'symmetric');
    case 'max'
        f = imdilate(g, ones(m,n));
    case 'min'
        f = imerode(g, ones(m,n));
    case 'midpoint'
        f1 = ordfilt2(g, 1, ones(m,n), 'symmetric');
        f2 = ordfilt2(g, m*n, ones(m,n), 'symmetric');
        f = imlincomb(0.5, f1, 0.5, f2);
    case 'atrimmed'
        f = alphatrim(g, m, n, d);
    otherwise
        error('Unknown Filter Type.')
end

    function f = gmean(g, m, n)
        g = im2double(g);
        f = exp(imfilter(log(g), ones(m,n), 'replicate')).^(1/m/n);
    end

    function f = harmean(g, m, n)
        g = im2double(g);
        f = m*n./imfilter(1./(g + eps), ones(m,n), 'replicate');
    end

    function f = charmean(g,m,n,q)
        g = im2double(g);
        f = imfilter(g.^(q+1), ones(m,n), 'replicate');
        f = f./(imfilter(g.^q, ones(m,n), 'replicate') + eps);
    end

    function f = alphatrim(g, m, n, d)
        if (d <= 0) || (d/2 ~= round(d/2))
            error('d must be a positive, even integer.')
        end
    
        g = im2double(g);
        f = imfilter(f, ones(m,n), 'symmetric');
        for k = 1:d/2
            f = f - ordfilt2(g, k, ones(m,n), 'symmetric');
        end

        for k = (m*n - (d/2) + 1):m*n
            f = f - ordfilt2(g, k, ones(m,n), 'symmetric');
        end

        f = f/(m*n - d);
    end

    function [m,n,Q,d] = parseInputs(varargin)

        m = 3;
        n = 3;
        Q = 1.5;
        d = 2;

        if nargin > 0
            m = varargin{1};
        end

        if nargin > 1
            n = varargin{2};
        end

        if nargin > 2
            Q = varargin{3};
            d = varargin{3};
        end
    end

end