function [U, V] = dftuv(M, N)
%DFTUV computes meshgrid frequency matrices.
%   [U, V] = DFTUV(M, N) computes meshgrid frequency matrices U and V. U
%   and V are useful for computing frequency-domain filter transfer
%   functions that can be used with function DFTFILT. U and V are both of
%   size MxN and of class double. 

%Variable Ranges
u = 0:(M - 1);
v = 0:(N - 1);

%Compute indices for use in mesh grid
idx = find(u > M/2);
u(idx) = u(idx) - M;

idy = find(v > N/2);
v(idy) = v(idy) - N;

%Compute Meshgrid
[V, U] = meshgrid(v, u);

end