clc;clear;close all ;
dbstop if error;
data_name = 'tmp_data/cpw_2D_W4-10_S3_10';
load([data_name,'.mat']);
part_freq_err = 'off';

%% scalable
order = [5 5];

[coeffs,RLGC_0123_2D_scalable]=fit_RLGC0123_2D_SVD( Width_array,Space_array,RLGC_0123_mat,order);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cpw_scalable_2D = cell(length(Space_array),length(Width_array));
cpw_scalable = new_cpwmodel_scalable();
freq = cpw_cell{1}.files_info(1).freq;
freq_max = 100e9;
freq_min = 60e9;
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
        if strcmp(part_freq_err,'on')
            cpw_scalable = cpwmodel_err_freq(cpw_scalable,freq_min,freq_max);% error of unit length
        else
            cpw_scalable = cpwmodel_err(cpw_scalable);
        end
        cpw_scalable = files_model(cpw_scalable);
        cpw_scalable = files_err(cpw_scalable);
        cpw_scalable_2D{n,m} = cpw_scalable;
        clear cpw_scalable;
    end
end

recycle('on')
save_name =[data_name,'_scalable'];
if strcmp(part_freq_err,'on')
    save_name =[save_name,'_freq'];
end
save_name =[save_name,'.mat'];
if exist(save_name,'file')
    delete(save_name);
end
save(save_name,'coeffs','cpw_cell','cpw_scalable_2D',...
               'RLGC_0123_2D_scalable','RLGC_0123_mat',...
               'Width_array','Space_array');
fprintf('Done!!!!!\n')










