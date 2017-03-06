function [ Y,jump_index ] = linkjump( X,diff,delta)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Check the reference impedance

jump_point = struct('index',0);
num_X = length(X);

% x = 0;
% x_next = 0 ;
%% find the jump point
N = 0;
for k=1:num_X-1
    x= X(k);
    x_next = X(k+1);
    if abs(x_next-x)>= diff
        N = N + 1;
        jump_point(N).index = k+1;
    end
end

Y = X;
jump_index = zeros(N,1);
if N~=0
    for m = 1:N-1
        Y(jump_point(m).index:jump_point(m+1).index-1) = X(jump_point(m).index:jump_point(m+1).index-1)+delta*m;
        jump_index(m) = jump_point(m).index;
    end
    
    Y(jump_point(N).index:end) = X(jump_point(N).index:end)+delta*N;
    jump_index(N) = jump_point(N).index;
end
end

