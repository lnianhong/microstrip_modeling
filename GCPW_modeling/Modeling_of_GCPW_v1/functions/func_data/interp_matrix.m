function [ vq_mat ] = interp_matrix( x,v_mat,xq,flg,method)
%input:
%   x: vector
%   v: matrix,size(v,1) = length(x)
%   xq:vector
%   vq_mat:matrix
narginchk(3,5);%
% Check the reference impedance
if nargin < 4
    flg = 'array';
end
if nargin < 5
    method = 'pchip';
end

if(size(x,1)*size(x,2) ~= length(x))
    error('x must be a array/vector!')
end

if(strcmp(flg,'array'))
    x = x';
    xq = xq';
    v_mat = v_mat';
end

vq_mat = zeros(length(xq),size(v_mat,2));
for k =1:size(v_mat,2)
    vq_mat(:,k) = interp1(x,v_mat(:,k),xq,method);   
end
if(strcmp(flg,'array'))
    vq_mat = vq_mat'; 
end

end

