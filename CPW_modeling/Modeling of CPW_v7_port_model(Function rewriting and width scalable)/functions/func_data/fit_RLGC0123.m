function [ fit_result] = fit_RLGC0123( var,RLGC0123_var)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if size(var,1)<size(var,2)
    var =var';
    RLGC0123_var = RLGC0123_var';    
end
fit_result = struct();%
for k=1:size(RLGC0123_var,2)
    ft=fit(var,RLGC0123_var(:,k),'poly3','Normalize','off','Robust','LAR');%'Bisquare'
    fit_result(k).cfit = ft;
end
end

