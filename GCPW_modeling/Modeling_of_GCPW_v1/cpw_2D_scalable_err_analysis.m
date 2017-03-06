clc;clear;close all;
data_name = 'tmp_data/cpw_2D_W4-10_S3_10';
part_freq_err = 'off';
save_name =[data_name,'_scalable'];
if strcmp(part_freq_err,'on')
    save_name =[save_name,'_freq'];
end
save_name =[save_name,'.mat'];
load(save_name);

err_gamma_z_ave = zeros(length(Space_array),length(Width_array),4);% average err of alpha beta real(Z) imag(Z)
err_gamma_z_max = zeros(length(Space_array),length(Width_array),4);% max err ofalpha beta real(Z) imag(Z)

err_RLGC_ave = zeros(length(Space_array),length(Width_array),4);% R L G C
err_RLGC_max = zeros(length(Space_array),length(Width_array),4);% R L G C

%cpw_scalable_2D{n,m}
for n = 1:length(Space_array)
    for m = 1:length(Width_array)
        err_struct  = get_errors_unit_length( cpw_scalable_2D{n,m});
        err_gamma_z_ave(n,m,:) =[err_struct.ave_err_alpha,err_struct.ave_err_beta,...
                                 err_struct.ave_err_Z_real,err_struct.ave_err_Z_imag]; 
        err_gamma_z_max(n,m,:) =[err_struct.max_err_alpha,err_struct.max_err_beta,...
                                 err_struct.max_err_Z_real,err_struct.max_err_Z_imag];
        err_RLGC_ave(n,m,:) = err_struct.ave_err_RLGC;
        err_RLGC_max(n,m,:) = err_struct.max_err_RLGC;
        clear err_struct;        
    end
end


plot_RLGCerr_2Dvar( err_RLGC_ave,err_RLGC_max,Width_array,Space_array,'width',3 );
plot_gamma_Z_err_2Dvar( err_gamma_z_ave,err_gamma_z_max,Width_array,Space_array,'width',3 );


str = {'width','space'};
var_str = str{2};
plot_RLGCerr_2Dvar_mult( err_RLGC_ave,Width_array,Space_array,...
                        var_str,['Ave Error of RLGC-Scalable along ',var_str]);
plot_RLGCerr_2Dvar_mult( err_RLGC_max,Width_array,Space_array,...
                        var_str,['Max Error of RLGC-Scalable along ',var_str]);
plot_gamma_Z_err_2Dvar_mult(err_gamma_z_ave,Width_array,Space_array,...
                            var_str,['Ave Error of gamma&Z-Scalable along ',var_str]);
plot_gamma_Z_err_2Dvar_mult( err_gamma_z_max,Width_array,Space_array,...
                            var_str,['Max Error of gamma&Z-Scalable along ',var_str]);


title_str = {'ave err of alpha','ave err of beta','ave err of real(Z)','ave err of imag(Z)'};
index = 1;
mesh_err_2D_single( Width_array,Space_array,err_gamma_z_ave(:,:,index),title_str{index});





