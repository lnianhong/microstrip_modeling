clc;clear;
file_ID = fopen('list.sp','w+');
generate_netlist( file_ID,'a','b','p',6)
fclose(file_ID);