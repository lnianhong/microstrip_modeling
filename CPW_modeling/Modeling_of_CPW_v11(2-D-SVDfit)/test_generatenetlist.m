clc;clear;close all;
load('tmp_data/cpwmodel_2D_scalable.mat');
file_name = 'cpw.sp';
file_ID = fopen(file_name,'w');
fprintf(file_ID,'.subckt cpw a b p len=220u width=4.4u space=4.4u scale=0.90909090909091\n');
fprintf(file_ID,'*\n');
num_sub = 4;
generate_param_2D(file_ID,coef_2D,num_sub);
fprintf(file_ID,'*\n');
fprintf(file_ID,'*\n');
generate_netlist( file_ID,'a','b','p',num_sub)
fprintf(file_ID,'*\n');
fprintf(file_ID,'.ends cpw');
fclose(file_ID);
copyfile('cpw.sp', 'E:\Software_Projects\Hspice_project\cpw_test\'); 