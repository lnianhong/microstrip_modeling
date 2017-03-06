clc;clear;close all ;
dbstop if error;
data = load('tmp_data/cpwmodels2-10.mat');
cpwmodel_table =data.cpwmodel; clear data;
cpwmodel_S =cpwmodel_table(1:9); 
var_array = [cpwmodel_S.space]; 

%% init the RLGC_0123_scalable_model_width
scalable_RLGC0123_var  = new_RLGC0123_scalable_model();
scalable_RLGC0123_var.field = 'space';%width or space
scalable_RLGC0123_var.field_data =var_array;
RLGC_0123_all = [cpwmodel_S.RLGC_0123];
R0123_var = reshape(RLGC_0123_all(:,1:4:end),4,[]);
L0123_var = reshape(RLGC_0123_all(:,2:4:end),4,[]);
G0123_var = reshape(RLGC_0123_all(:,3:4:end),4,[]);
C0123_var = reshape(RLGC_0123_all(:,4:4:end),4,[]);
scalable_RLGC0123_var.RLGC_0123 = [R0123_var;L0123_var;G0123_var;C0123_var];
% interp the data
scalable_RLGC0123_var.field_data_interp = min(var_array):0.1*1e-6:max(var_array);
scalable_RLGC0123_var.RLGC_0123_interp = interp_matrix( var_array,scalable_RLGC0123_var.RLGC_0123,...
                                         scalable_RLGC0123_var.field_data_interp);

% fit the RLGC 0123                                
scalable_RLGC0123_var.fitfunc_type = 'poly3';
% RLGC_0123_scalable_model.cfit = {};
[ fit_result] = fit_RLGC0123( scalable_RLGC0123_var.field_data_interp,...
                              scalable_RLGC0123_var.RLGC_0123_interp);
scalable_RLGC0123_var.cfit_struct = fit_result;
% get the coef
coef = zeros(16,4);
for k=1:16
    coef(k,:) = [fit_result(k).cfit.p1,fit_result(k).cfit.p2,...
            fit_result(k).cfit.p3,fit_result(k).cfit.p4];
end
scalable_RLGC0123_var.coef = coef;
field_data = scalable_RLGC0123_var.field_data;
field_data_poly3 = [field_data.^3;field_data.^2;field_data.^1;field_data.^0];
scalable_RLGC0123_var.RLGC_0123_scalable = (scalable_RLGC0123_var.coef)*field_data_poly3;
plot_RLGC0123_scalable(scalable_RLGC0123_var);

cpwmodel_scalable = new_cpwmodel_scalable();
freq = cpwmodel_S(1).files_info(1).freq;
for m = 1:length(var_array)
%     width = var_array(m);
    %% basic info of model
    cpwmodel_scalable(m).files_info = cpwmodel_S(m).files_info;
    cpwmodel_scalable(m).len = cpwmodel_S(m).len;
    cpwmodel_scalable(m).width = cpwmodel_S(m).width;
    cpwmodel_scalable(m).space = cpwmodel_S(m).space;
    cpwmodel_scalable(m).RLGC_sim = cpwmodel_S(m).RLGC_sim;
    cpwmodel_scalable(m).RLGC_f_sim = cpwmodel_S(m).RLGC_f_sim;
    cpwmodel_scalable(m).RLGC_0123 = reshape(scalable_RLGC0123_var.RLGC_0123_scalable(:,m),4,[]);
    cpwmodel_scalable(m).RLGC_fit = RLGC0123_2_RLGC( freq,cpwmodel_scalable(m).RLGC_0123);
    cpwmodel_scalable(m).gamma_sim = RLGC_2_gamma( cpwmodel_scalable(m).RLGC_sim,freq);
    cpwmodel_scalable(m).gamma_fit = RLGC_2_gamma( cpwmodel_scalable(m).RLGC_fit,freq);
    cpwmodel_scalable(m) = cpwmodel_err(cpwmodel_scalable(m));% error of unit length
    cpwmodel_scalable(m) = files_model(cpwmodel_scalable(m));
    cpwmodel_scalable(m) = files_err(cpwmodel_scalable(m));
end
cpwmodel_all = struct();
cpwmodel_all.table_space_model = cpwmodel_table;
cpwmodel_all.scalable_space_model = cpwmodel_scalable;
cpwmodel_all.scalable_space_info = scalable_RLGC0123_var;


recycle('on')
save_name ='./tmp_data/cpwmodel_all_spacescalable.mat';
if exist(save_name,'file')
    delete(save_name);
end
save(save_name,'cpwmodel_all')


