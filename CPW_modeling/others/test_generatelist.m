clc;clear;
file_ID = fopen('list.sp','w+');
generate_netlist( file_ID,'a','b','p',1)
fclose(file_ID);