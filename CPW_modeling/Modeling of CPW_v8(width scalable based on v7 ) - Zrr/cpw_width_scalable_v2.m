clc;clear;close all ;
dbstop if error;
data = load('tmp_data/cpwmodelw4-12.mat');
cpwmodel_table =data.cpwmodel; clear data;
cpwmodel_w =cpwmodel_table(2:7); 
Width_array = [cpwmodel_w.width]; 

%% init the RLGC_0123_scalable_model_width
scalable_RLGC0123_width  = new_RLGC0123_scalable_model();
scalable_RLGC0123_width.field = 'width';%width or space
scalable_RLGC0123_width.field_data =Width_array;
RLGC_0123_all = [cpwmodel_w.RLGC_0123];
R0123_width = reshape(RLGC_0123_all(:,1:4:end),4,[]);
L0123_width = reshape(RLGC_0123_all(:,2:4:end),4,[]);
G0123_width = reshape(RLGC_0123_all(:,3:4:end),4,[]);
C0123_width = reshape(RLGC_0123_all(:,4:4:end),4,[]);
scalable_RLGC0123_width.RLGC_0123 = [R0123_width;L0123_width;G0123_width;C0123_width];
% interp the data
scalable_RLGC0123_width.field_data_interp = min(Width_array):0.1*1e-6:max(Width_array);
scalable_RLGC0123_width.RLGC_0123_interp = interp_matrix( Width_array,scalable_RLGC0123_width.RLGC_0123,...
                                         scalable_RLGC0123_width.field_data_interp);

% fit the RLGC 0123                                
scalable_RLGC0123_width.fitfunc_type = 'poly3';
% RLGC_0123_scalable_model.cfit = {};
[ fit_result] = fit_RLGC0123( scalable_RLGC0123_width.field_data_interp,...
                              scalable_RLGC0123_width.RLGC_0123_interp);
scalable_RLGC0123_width.cfit_struct = fit_result;
% get the coef
coef = zeros(16,4);
for k=1:16
    coef(k,:) = [fit_result(k).cfit.p1,fit_result(k).cfit.p2,...
            fit_result(k).cfit.p3,fit_result(k).cfit.p4];
end
scalable_RLGC0123_width.coef = coef;
field_data = scalable_RLGC0123_width.field_data;
field_data_poly3 = [field_data.^3;field_data.^2;field_data.^1;field_data.^0];
scalable_RLGC0123_width.RLGC_0123_scalable = (scalable_RLGC0123_width.coef)*field_data_poly3;
plot_RLGC0123_scalable(scalable_RLGC0123_width);

cpwmodel_scalable = new_cpwmodel_scalable();
freq = cpwmodel_w(1).files_info(1).freq;
for m = 1:length(Width_array)
    width = Width_array(m);
    %% basic info of model
    cpwmodel_scalable(m).files_info = cpwmodel_w(m).files_info;
    cpwmodel_scalable(m).len = cpwmodel_w(m).len;
    cpwmodel_scalable(m).width = cpwmodel_w(m).width;
    cpwmodel_scalable(m).space = cpwmodel_w(m).space;
    cpwmodel_scalable(m).RLGC_sim = cpwmodel_w(m).RLGC_sim;
    cpwmodel_scalable(m).RLGC_f_sim = cpwmodel_w(m).RLGC_f_sim;
    cpwmodel_scalable(m).RLGC_0123 = reshape(scalable_RLGC0123_width.RLGC_0123_scalable(:,m),4,[]);
    cpwmodel_scalable(m).RLGC_fit = RLGC0123_2_RLGC( freq,cpwmodel_scalable(m).RLGC_0123);
    cpwmodel_scalable(m).gamma_sim = RLGC_2_gamma( cpwmodel_scalable(m).RLGC_sim,freq);
    cpwmodel_scalable(m).gamma_fit = RLGC_2_gamma( cpwmodel_scalable(m).RLGC_fit,freq);
    cpwmodel_scalable(m) = cpwmodel_err(cpwmodel_scalable(m));% error of unit length
    cpwmodel_scalable(m) = files_model(cpwmodel_scalable(m));
    cpwmodel_scalable(m) = files_err(cpwmodel_scalable(m));
end
cpwmodel_all = struct();
cpwmodel_all.table_width_model = cpwmodel_table;
cpwmodel_all.scalable_width_model = cpwmodel_scalable;
cpwmodel_all.scalable_width_info = scalable_RLGC0123_width;

save('./tmp_data/cpwmodel_all_widthscalable.mat','cpwmodel_all')


