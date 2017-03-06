clc;clear;close all ;
dbstop if error;
data = load('tmp_data/cpwmodelw4-12.mat');
cpwmodel_all =data.cpwmodel; clear data;
cpwmodel_w =cpwmodel_all(2:7); 
Width_array = [cpwmodel_w.width]; 

%% init the RLGC_0123_scalable_model_width
scalable_width  = new_RLGC0123_scalable_model();
scalable_width.field = 'width';%width or space
scalable_width.field_data =Width_array;

RLGC_0123_all = [cpwmodel_w.RLGC_0123];

R0123_width = reshape(RLGC_0123_all(:,1:4:end),4,[]);
L0123_width = reshape(RLGC_0123_all(:,2:4:end),4,[]);
G0123_width = reshape(RLGC_0123_all(:,3:4:end),4,[]);
C0123_width = reshape(RLGC_0123_all(:,4:4:end),4,[]);

scalable_width.RLGC_0123 = [R0123_width;L0123_width;G0123_width;C0123_width];

% interp the data
scalable_width.field_data_interp = min(Width_array):0.1*1e-6:max(Width_array);
scalable_width.RLGC_0123_interp = interp_matrix( Width_array,scalable_width.RLGC_0123,...
                                         scalable_width.field_data_interp);

% fit the RLGC 0123                                
scalable_width.fitfunc_type = 'poly3';
% RLGC_0123_scalable_model.cfit = {};
[ fit_result] = fit_RLGC0123( scalable_width.field_data_interp,...
                              scalable_width.RLGC_0123_interp);
scalable_width.cfit_struct = fit_result;
% get the coef
coef = zeros(16,4);
for k=1:16
    coef(k,:) = [fit_result(k).cfit.p1,fit_result(k).cfit.p2,...
            fit_result(k).cfit.p3,fit_result(k).cfit.p4];
end
scalable_width.coef = coef;
field_data = scalable_width.field_data;
field_data_poly3 = [field_data.^3;field_data.^2;field_data.^1;field_data.^0];
scalable_width.RLGC_0123_scalable = (scalable_width.coef)*field_data_poly3;

plot_RLGC0123_scalable(scalable_width);






