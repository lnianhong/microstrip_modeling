function [ coef ] = get_scalable_coef( fit_result,num_coef )
%get the poly3 scalable function coefs
coef = zeros(16,num_coef);
for k=1:16
    coef(k,:) = [fit_result(k).cfit.p1,fit_result(k).cfit.p2,...
            fit_result(k).cfit.p3,fit_result(k).cfit.p4];
end

end

