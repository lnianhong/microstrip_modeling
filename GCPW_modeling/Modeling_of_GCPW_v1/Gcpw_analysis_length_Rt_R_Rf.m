% 考虑分端口效应，端口效应没有GC），模型验证方法（本征+叠加端口）
clc;clear;close all
dbstop if error;
len = [ 150 200 250 300 350 ];%W ==5
len_pi = 12.5*1e-6;
space = 10;
width = 4;
files_info  = new_files_info();
for k = 1:length(len)
    files_info(k).name=sprintf('./S_parameters_sim/GCPW_test/L%dW%dS%d.csv',len(k),width,space);
    files_info(k).length = len(k)*1e-6;
    files_info(k).width = width*1e-6;
    files_info(k).space = space*1e-6;
    files_info(k).len_pi =len_pi ;
    files_info(k).num_pi = ceil(files_info(k).length/files_info(k).len_pi-1e-6);
end
[ files_info,RLGC_sim,RLGC_f_sim] = reg_RLGC( files_info);
freq = files_info(1).freq;
[ RLGC_fit,RLGC_0123,f_fit ] = RLGC_2_0123( RLGC_sim,freq);
plot_RLGC_double(freq,RLGC_sim,RLGC_fit,{'sim','fit'},'RLGC: sim vs fit',{'-r','--b'});
cpw_model = new_cpwmodel();
cpw_model(1).files_info = files_info;
cpw_model(1).len = len;
cpw_model(1).width = width;
cpw_model(1).space = space;
cpw_model(1).RLGC_sim = RLGC_sim;
cpw_model(1).RLGC_f_sim = RLGC_f_sim;
cpw_model(1).RLGC_fit = RLGC_fit;
cpw_model(1).RLGC_0123 = RLGC_0123;
cpw_model(1).f_fit = f_fit;

%% Test model

index_test = 5;
len_test = files_info(index_test).length;
num_pi = ceil(len_test*1e6/12.5);
% if strcmp(mode{2},'add')
[ S_model_test_mid] = cpw_model_pi_net(freq,cpw_model(1).RLGC_0123,len_test,num_pi);
[RLGC_model_test_mid,gamma_model_test_mid]...
    = S_2_RLGC(S_model_test_mid,freq,len_test);
RLGC_model_test_total_add = RLGC_model_test_mid + 4*cpw_model(1).RLGC_f_sim ./ len_test;

RLGC_sim_test_total = files_info(index_test).RLGC_total;
%% plot RLGC
figure_title = ['RLGC(total): sim vs model-',num2str(len_test*1e6),'um'];
plot_RLGC_double(freq,RLGC_sim_test_total,RLGC_model_test_total_add,{'sim-total','model-total'},figure_title,{'-r','--b'});
axis([0 inf 0 inf])
axis 'auto x'
%% plot gamma
gamma_sim = files_info(index_test).gamma_total ;
gamma_model_test = RLGC_2_gamma( RLGC_model_test_total_add,freq);
figure_title = ['alpha and beta(total): sim vs model-',num2str(len_test*1e6),'um'];
[Err_alpha,Err_beta ]=plot_gamma_double(freq,gamma_sim,gamma_model_test,{'sim','model'},figure_title,{'-r','--b'} );
disp_alpha_beta_err( Err_alpha,Err_beta,'Error of alpha & beta' );
%% plot Z
Z_sim = files_info(index_test).Z_total ;
Z_model_test = RLGC_2_Z( RLGC_model_test_total_add,freq);
figure_title = ['Z: sim vs model-',num2str(len_test*1e6),'um'];
plot_gamma_double(freq,Z_sim,Z_model_test,{'sim','model'},figure_title,{'-r','--b'} );




