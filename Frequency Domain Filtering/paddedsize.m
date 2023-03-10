function PQ = paddedsize(AB, CD, PARAM)
%PADDEDSIZE Computes padded sizes useful for FFT-based filtering.
%   PQ = PADDEDSIZE(AB), where AB is a two-element vector, computes the
%   two-element vector PQ = 2*AB.

%   PQ = PADDEDSIZE(AB, 'PWR2') computes the vector PQ such that PQ(1) =
%   PQ(2) = 2^nextpow2(2*m), where m is MAX(AB).

%   PQ = PADDEDSIZE(AB, CD), where AB and CD are two-element size vectors,
%   computes the two-element size vector PQ. The elements of PQ are the
%   smallenst even integers greater than or equal to AB + CD - 1.

%   PQ = PADDEDSIZE(AB, CD, 'PWR2') computes the vector PQ such that PQ(1)
%   = PQ(2) = 2^nextpow2(2*m), where m is MAX([AB, CD]).

if nargin == 1
    PQ = 2*AB;
elseif nargin == 2 && ~ischar(CD)
    PQ = AB + CD - 1;
    PQ = 2*ceil(PQ/2);
elseif nargin == 2
    m = max(AB);            %max dimension

    P = 2^nextpow2(2*m);    %Compute power of 2, at least twice m.
    PQ = [P,P];
elseif (nargin == 3) && strcmpi(PARAM, 'pwr2')
    m = max([AB, CD]);      % max dimension

    P = 2^nextpow2(2*m);    %Compute power of 2, at least twice m.
    PQ = [P,P];
else
    error('Wrong number of inputs.')
end