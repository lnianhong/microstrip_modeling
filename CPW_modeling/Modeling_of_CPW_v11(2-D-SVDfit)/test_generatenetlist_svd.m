clc;clear;close all;
data_name = 'tmp_data/cpw_2D_W4-10_S3_10';
part_freq_err = 'on';
save_name =[data_name,'_scalable'];
if strcmp(part_freq_err,'on')
    save_name =[save_name,'_freq'];
end
save_name =[save_name,'.mat'];
load(save_name);
%% generate netlist
num_sub = 10;
file_name = 'hspice_project/test_cpw/cpw.sp';
file_ID = fopen(file_name,'w');
fprintf(file_ID,'.subckt cpw a b p len=220u width=4.4u space=4.4u scale=0.90909090909091\n');
fprintf(file_ID,'*\n');
generate_param_2D_svd(file_ID,coeffs,num_sub,[3,3]);
fprintf(file_ID,'*\n');
fprintf(file_ID,'*\n');
generate_netlist( file_ID,'a','b','p',num_sub)
fprintf(file_ID,'*\n');
fprintf(file_ID,'.ends cpw');
fclose(file_ID);

