clc;clear;close all ;
dbstop if error;
data_name = 'tmp_data/cpw_2D_W4-10_S2_2_10';
load([data_name,'.mat']);
% Width_array = Width_array*1e-6;
% Space_array = Space_array*1e-6;
coef_2D = fit_RLGC0123_2D( Width_array,Space_array,RLGC_0123_mat,'width');


RLGC_0123_2D_scalable = zeros(size(RLGC_0123_mat));
Space_tmp = repmat(Space_array',1,4).^[3 2 1 0];
Width_tmp = repmat(Width_array',1,4).^[3 2 1 0];
for k = 1:16 % 16 means RLGC0123
    RLGC_0123_2D_scalable(:,:,k) = Space_tmp*coef_2D(:,:,k)*(Width_tmp)';
end
 RLGC_0123_2D_scalable(RLGC_0123_2D_scalable<0)=1e-18;

%% plot the scalable result
plot_RLGC_2D_scalable_var( RLGC_0123_mat,coef_2D,Width_array,Space_array,'space',1 );
plot_RLGC_2D_scalable_var( RLGC_0123_mat,coef_2D,Width_array,Space_array,'width',1 );
mesh_RLGC_2D_double( RLGC_0123_mat,coef_2D,Width_array,Space_array,9);

cpw_scalable_2D = cell(length(Space_array),length(Width_array));
cpw_scalable = new_cpwmodel_scalable();
freq = cpw_cell{1}.files_info(1).freq;
for n = 1:length(Space_array)
    for m = 1:length(Width_array)
        %% basic info of model
        cpw_scalable = new_cpwmodel_scalable();
        cpw_scalable.files_info = cpw_cell{n,m}.files_info;
        cpw_scalable.len = cpw_cell{n,m}.len;
        cpw_scalable.width = cpw_cell{n,m}.width;
        cpw_scalable.space = cpw_cell{n,m}.space;
        cpw_scalable.RLGC_sim = cpw_cell{n,m}.RLGC_sim;
        cpw_scalable.RLGC_f_sim = cpw_cell{n,m}.RLGC_f_sim;
        cpw_scalable.RLGC_0123 = reshape(RLGC_0123_2D_scalable(n,m,:),4,[]);
        cpw_scalable.RLGC_fit = RLGC0123_2_RLGC( freq,cpw_scalable.RLGC_0123);
        cpw_scalable.gamma_sim = RLGC_2_gamma( cpw_scalable.RLGC_sim,freq);
        cpw_scalable.gamma_fit = RLGC_2_gamma( cpw_scalable.RLGC_fit,freq);
        cpw_scalable = cpwmodel_err(cpw_scalable);% error of unit length
        cpw_scalable = files_model(cpw_scalable);
        cpw_scalable = files_err(cpw_scalable);
        cpw_scalable_2D{n,m} = cpw_scalable;
        clear cpw_scalable;
    end
end

recycle('on')
save_name =[data_name,'_scalable','.mat'];
if exist(save_name,'file')
    delete(save_name);
end
save(save_name,'coef_2D','cpw_cell','cpw_scalable_2D',...
               'RLGC_0123_2D_scalable','RLGC_0123_mat',...
               'Width_array','Space_array');

% save('./tmp_data/cpwmodel_all_widthscalable_v2.mat','cpwmodel_all')










