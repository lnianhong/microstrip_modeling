function [ coef_2D] = fit_RLGC0123_2D( Width_array,Space_array,RLGC_0123_mat,first_var)
% get the scalable function of RLGC0123
% the var should be a vector,each column of RLGC0123_var is a samle

%% interp the data
[Width_array_grid,Space_array_grid] = meshgrid(Width_array,Space_array);
W_interp = min(Width_array):0.1:max(Width_array);
S_interp = min(Space_array):0.1:max(Space_array);
% W_interp = min(Width_array):0.1*1e-6:max(Width_array);
% S_interp = min(Space_array):0.1*1e-6:max(Space_array);
[W_interp_grid,S_interp_grid] = meshgrid(W_interp,S_interp);
RLGC_0123_interp = zeros(length(S_interp),length(W_interp),16);
for ii=1:16
    RLGC_0123_interp(:,:,ii) = interp2(Width_array_grid,Space_array_grid,RLGC_0123_mat(:,:,ii),...
                                       W_interp_grid,S_interp_grid,'cubic');
end
%% R = f(w)*S^3 + g(w)*S^2 + h(w)*S + j(w)
if strcmp(first_var,'space')
    % fit the RLGC 0123
    coef_2D = zeros(4,4,16);
    coef_s = zeros(length(W_interp),4,16);% 16 means RLGC0123,coef of s;coef(s) = f(w)
    for index = 1:length(W_interp)
        RLGC_0123_interp_s = permute(RLGC_0123_interp(:,index,:),[3,1,2]);
        [ fit_result] = fit_RLGC0123( S_interp',RLGC_0123_interp_s');
        % get the coef
        for k=1:16% 16 means RLGC0123
            coef_s(index,:,k) = [fit_result(k).cfit.p1,fit_result(k).cfit.p2,...
                fit_result(k).cfit.p3,fit_result(k).cfit.p4];
        end
        clear fit_result;
    end
 
    for k=1:16% 16 means RLGC0123
        [ fit_result] = fit_RLGC0123( W_interp',coef_s(:,:,k)); %coef(s) = f(w)
        for m=1:4
            coef_2D(:,m,k) = [fit_result(m).cfit.p1;fit_result(m).cfit.p2;...
                fit_result(m).cfit.p3;fit_result(m).cfit.p4];
        end
        clear fit_result;
    end
    % change R = f(w)*S^3 + g(w)*S^2 + h(w)*S + j(w) to R = f(s)*W^3 + g(s)*W^2 + h(s)*W + j(s)
    coef_2D = permute(coef_2D,[2,1,3]);  
end

%% R = f(s)*W^3 + g(s)*W^2 + h(s)*W + j(s)
if strcmp(first_var,'width')
    % fit the RLGC 0123
    coef_2D = zeros(4,4,16);
    coef_w = zeros(length(S_interp),4,16);% 16 means RLGC0123
    for index = 1:length(S_interp)
        RLGC_0123_interp_w = permute(RLGC_0123_interp(index,:,:),[3,2,1]);
        [ fit_result] = fit_RLGC0123( W_interp',RLGC_0123_interp_w');
        % get the coef
        for k=1:16% 16 means RLGC0123
            coef_w(index,:,k) = [fit_result(k).cfit.p1,fit_result(k).cfit.p2,...
                fit_result(k).cfit.p3,fit_result(k).cfit.p4];
        end
        clear fit_result;
    end
 
    for k=1:16% 16 means RLGC0123
        [ fit_result] = fit_RLGC0123( S_interp',coef_w(:,:,k));
        for m=1:4
            coef_2D(:,m,k) = [fit_result(m).cfit.p1;fit_result(m).cfit.p2;...
                fit_result(m).cfit.p3;fit_result(m).cfit.p4];
        end
        clear fit_result;
    end
end
end

