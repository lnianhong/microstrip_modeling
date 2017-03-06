clc;clear;
hspice = 'D:\synopsys\Hspice_C-2009.09\BIN\hspicerf.exe';
file_name = 'E:\Software_Projects\Hspice_project\cpw_test\test_cpw_sparam';
cmd = [hspice,' -i ',file_name,'.sp',' -o ',file_name];
dos(cmd)