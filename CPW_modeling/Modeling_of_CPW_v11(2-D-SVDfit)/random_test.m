clc;clear;close all;
%% load data
data_name = 'tmp_data/cpw4test.mat';
load(data_name);
data_name = 'tmp_data/cpw_2D_W4-10_S3_10_scalable.mat';
load(data_name);
%% generate cpw subckt netlist
folder_path = 'hspice_project/cpw/';
sp_name = 'cpw';
file_name = [folder_path,sp_name,'.sp'];
order =[3 3];num_sub = 10;
cpw_subckt_sp( file_name,coeffs,order,num_sub );
%% generate hspice test-case netlist
test_fileTitle = ['test_',sp_name];
test_file = [folder_path,test_fileTitle,'.sp'];
len = 350;
width_array = [4.5 5.5 6.5];
space_array = [4 4 4];
w_ind = 1;
s_ind = 1;
width = width_array(w_ind);
space = space_array(s_ind);
file_ID = fopen(test_file,'w');
fprintf(file_ID,'.Title %s\n',test_fileTitle);
sp_path_absolute = [pwd,'/',file_name];
sp_path_absolute = strrep(sp_path_absolute,'/','\');
fprintf(file_ID,'.include ''%s''\n',sp_path_absolute);
fprintf(file_ID,'.option post=1 runlvl=6\n') ;%post =1 is must! binary output
fprintf(file_ID,'.temp 27\n');
scale_coef = 1./0.9;
fprintf(file_ID,'x1 a b 0 cpw len=%.2fu width=%.2fu space=%.2fu\n',...
                 len*scale_coef,width*scale_coef,space*scale_coef);
fprintf(file_ID,'P1 a 0 port=1  z0=50\n'); 
fprintf(file_ID,'P2 b 0 port=2  z0=50\n');
fprintf(file_ID,'* Measure s-parameters\n'); 
fprintf(file_ID,'.AC LIN 200 0.5G 100G\n');
fprintf(file_ID,'.LIN sparcalc=1 modelname=test_cpw filename=test_cpw format=selem dataformat=ri SPARDIGIT=15\n');
fprintf(file_ID,'.PRINT S11(R) S11(I) S21(R) S21(I) S12(R) S12(I) S22(R) S22(I)\n');
fprintf(file_ID,'.end\n');
fclose(file_ID);
%% hspice simulation
t1= clock;
[ S_hspice,freq ] = hspice2S( test_file);
t2 = clock;
hspice_time = etime(t2,t1);
fprintf('Subckt: %d\t Hspice simulation time:%f\n',num_sub,hspice_time);
%% matlab calculate
op = eval_2Dscalable_svd( width,space,coeffs,[3 3]);
RLGC_0123 = reshape(op',4,4);


S_matlab = cpw_model_pi_net(freq,RLGC_0123,len*1e-6,num_sub);
%% HFSS simulation
S_sim_total = cpw4test{1,w_ind}.files_info(round((len-100)/50)).Sparam_total;

S_sim_i = cpw4test{1,w_ind}.files_info(round((len-100)/50)).Sparam_i;
plot_Sparam_double_Real_Imag( freq,S_hspice,S_matlab,{'hspice','matlab'},'hspice VS matlab','off');
plot_Sparam_double_Real_Imag( freq,S_hspice,S_sim_total,{'hspice','sim\_total'},'hspice VS sim_total','off');
plot_Sparam_double_Real_Imag( freq,S_hspice,S_sim_i,{'hspice','sim\_i'},'hspice VS sim_i','off');
plot_Sparam_double_Real_Imag( freq,S_sim_total,S_sim_i,{'sim\_total','sim\_i'},'sim_total VS sim_i','off');

[RLGC_hspice,gamma_hspice,Z_hspice] = S_2_RLGC(S_hspice,freq,len*1e-6); % the unit length is meter!
[RLGC_matlab,gamma_matlab,Z_matlab] = S_2_RLGC(S_matlab,freq,len*1e-6); % the unit length is meter!
[RLGC_total,gamma_total,Z_total]    = S_2_RLGC(S_sim_total,freq,len*1e-6); % the unit length is meter!
[RLGC_i,    gamma_i,    Z_i]        = S_2_RLGC(S_sim_i,freq,len*1e-6); % the unit length is meter!
plot_RLGC_double(freq,RLGC_hspice,RLGC_matlab,{'hspice','matlab'},'RLGC: hspice vs matlab',{'-r','--b'});
plot_RLGC_double(freq,RLGC_hspice,RLGC_i,{'hspice','sim\_i'},'RLGC: hspice vs sim_i',{'-r','--b'});
plot_RLGC_double(freq,RLGC_hspice,RLGC_total,{'hspice','sim\_total'},'RLGC: hspice vs sim_total',{'-r','--b'});







