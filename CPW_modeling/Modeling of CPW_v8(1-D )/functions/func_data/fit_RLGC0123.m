function [ fit_result] = fit_RLGC0123( var,RLGC0123_var)
% get the scalable function of RLGC0123
% the var should be a vector,each column of RLGC0123_var is a samle 
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

