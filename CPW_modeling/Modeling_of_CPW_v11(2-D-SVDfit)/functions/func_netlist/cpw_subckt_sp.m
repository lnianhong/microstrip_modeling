function [ flag ] = cpw_subckt_sp( file_name,coeffs,order,num_sub )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% num_sub = 10;
% file_name = 'hspice_project/test_cpw/cpw.sp';
flag = 0;
file_ID = fopen(file_name,'w');
fprintf(file_ID,'.subckt cpw a b p len=220u width=8u space=8u scale=0.9\n');
fprintf(file_ID,'*\n');
fprintf(file_ID,['********************************'...,
                 '*******************************************\n']);
fprintf(file_ID,'*\n');
fprintf(file_ID,'* NOTES:\n');
fprintf(file_ID,'*\n');
fprintf(file_ID,'*  1. Length can vary continuously from 150um to 400um\n');
fprintf(file_ID,'*\n');
fprintf(file_ID,'*  2. Width can vary continuously from 4.44um to 11.11um\n');
fprintf(file_ID,'*\n');
fprintf(file_ID,'*  3. Space can vary continuously from 3.33um to 11.11um.\n');
fprintf(file_ID,'*\n');
fprintf(file_ID,['***************************'...,
                 '************************************************\n']);
fprintf(file_ID,'*\n');
generate_param_2D_svd(file_ID,coeffs,num_sub,order);
fprintf(file_ID,'*\n');
fprintf(file_ID,'*\n');
generate_netlist( file_ID,'a','b','p',num_sub)
fprintf(file_ID,'*\n');
fprintf(file_ID,'.ends cpw');
fclose(file_ID);
flag = 1;
end

