%对比检查两种模型验证方法的结果，结果不同以及不同的原因（RL向GC转换）
clc;clear;close all
dbstop if error;
addpath('./function')

mode = {'reg(RL)+mu(GC)','S'};

% len = [150,175,200,225,250,275,300,350,375];
len = [150,200,250,300,350];%W ==5
width = 4;
files_num = length(len);
R_0123 = zeros(4,files_num);
L_0123 = zeros(4,files_num);
G_0123 = zeros(4,files_num);
C_0123 = zeros(4,files_num);
f_min = 0.5;
f_max = 100;
freq_min = 0.5e9;
freq_max = 100e9;
freq_min_max = [f_min,f_max]*1e9;
num_freq_point = 2*f_max; 
R_sim_total = zeros(num_freq_point,files_num);
L_sim_total = zeros(num_freq_point,files_num);
G_sim_total = zeros(num_freq_point,files_num);
C_sim_total = zeros(num_freq_point,files_num);


alpha_sim_total = zeros(num_freq_point,files_num);
beta_sim_total = zeros(num_freq_point,files_num);

for k = 1:files_num

    file_name =sprintf('./S_parameters_sim/width/W%d/L%dW%dS4.csv',width,len(k),width);
    len(k) = len(k)*1e-6;
    zero_freq = 0;
    [ s_params,freq] = hfss_csv_2_sparams(file_name,zero_freq,'GHz');
    if max(freq)< freq_max || min(freq)>freq_min
        error('max(freq)< freq_max || min(freq)>freq_min');
    end
    s_params = s_params(:,:,freq<=freq_max & freq>=freq_min );
    freq = freq(freq<=freq_max & freq>=freq_min );
    [R_sim_total(:,k),L_sim_total(:,k),G_sim_total(:,k),C_sim_total(:,k),gamma,Z0] = ...,
        S_2_RLGC(s_params,freq,len(k)); % the unit length is meter!
    alpha_sim_total(:,k) = real(gamma);
    beta_sim_total(:,k) = imag(gamma);
end

if len(1)>1
    len = len *1e-6;
end

one_div_len = 1./len;

[ R_sim,Rf_sim ] = Rt_2_R_Rf( one_div_len,R_sim_total,num_freq_point);
[ L_sim,Lf_sim ] = Rt_2_R_Rf( one_div_len,L_sim_total,num_freq_point);
if strcmp(mode{1},'reg(RLGC)')
    [ G_sim,Gf_sim ] = Rt_2_R_Rf( one_div_len,G_sim_total,num_freq_point);
    [ C_sim,Cf_sim ] = Rt_2_R_Rf( one_div_len,C_sim_total,num_freq_point);
end
if strcmp(mode{1},'reg(RL)+mu(GC)')
    C_sim = mean(C_sim_total,2);
    Cf_sim = zeros(size(C_sim));
    G_sim = mean(G_sim_total,2);
    Gf_sim = zeros(size(G_sim));

end
%     plot_4_single(freq,y1,legend_text,x_label,y_label,main_title,sty);
f_2_zone = (4:0.5:25)*1e9;
f_1 = 1e9*ones(1,length(f_2_zone));%GHz
f_3 = freq_max*ones(1,length(f_2_zone));
f_123_mat = [f_1;f_2_zone;f_3];
%% model RL
lambda_RL = [0.5;0.5];
weight_RL = ones(length(freq),2);
weight_RL(100:200,:) = weight_RL(100:200,:)*10;
fun = @(A,B) A./B;
weight_RL = bsxfun(fun,weight_RL,sum(weight_RL,1));
[R_fit,L_fit,R_0123_fit,L_0123_fit,f_fit_RL,Err_RL,Err_min_RL] =...,
    fit_RLGC(f_123_mat,freq,R_sim,L_sim,G_sim,C_sim,lambda_RL,weight_RL,'RL',3);
%% model GC
lambda_GC = [0.5;0.5];
weight_GC = ones(length(freq),2);
weight_GC(100:200,:) = weight_GC(100:200,:)*1;
weight_GC = bsxfun(fun,weight_GC,sum(weight_GC,1));
[G_fit,C_fit,G_0123_fit,C_0123_fit,f_fit_GC,Err_GC,Err_min_GC] = ...,
    fit_RLGC(f_123_mat,freq,R_sim,L_sim,G_sim,C_sim,lambda_GC,weight_GC,'GC',3);

%% RLGC display
RLGC_sim = [R_sim,L_sim,G_sim,C_sim];
RLGC_fit = [R_fit,L_fit,G_fit,C_fit];
plot_RLGC_double(freq,RLGC_sim,RLGC_fit,{'sim','fit'},'RLGC: sim vs fit',{'-r','--b'});


%% Test model


index_test = 4; %find(len == len_test);
len_test = len(index_test);
num_pi = ceil(len_test*1e6/12.5);

% if strcmp(mode{2},'add')
    [ S_model_test_mid] = cpw_model_pi_net(freq,R_0123_fit,L_0123_fit,G_0123_fit,C_0123_fit,f_fit_RL,f_fit_GC,len_test,num_pi);
    [R_model_test_mid,L_model_test_mid,G_model_test_mid,C_model_test_mid,gamma_model_test]...
    = S_2_RLGC(S_model_test_mid,freq,len_test);
    RLGC_model_test_total_add = [R_model_test_mid+4*Rf_sim./len_test,L_model_test_mid+4*Lf_sim./len_test,...
                             G_model_test_mid+4*Gf_sim./len_test,C_model_test_mid+4*Cf_sim./len_test];
                         
                         
%     abcd_mid = s2abcd(S_model_test_mid);
    
% end
% if strcmp(mode{2},'S')
    RLGC_model_test_mid = [R_model_test_mid,L_model_test_mid,G_model_test_mid,C_model_test_mid];
    plot_RLGC_double(freq,RLGC_model_test_mid,RLGC_fit,{'test-mid','fit'},'RLGC: model vs fit',{'-r','--b'});
    plot_RLGC_double(freq,RLGC_model_test_mid,RLGC_model_test_total_add,{'test-mid','add'},'RLGC: mid vs add',{'-r','--b'});
    
    [ S_model_test_total] = cpw_model_pi_net_R_Rt_Rf(freq,R_0123_fit,L_0123_fit,...,
                                                G_0123_fit,C_0123_fit,...,
                                                Rf_sim,Lf_sim,Gf_sim,Cf_sim,...
                                                f_fit_RL,f_fit_GC,...,
                                                len_test,num_pi);
    [R_model_test_total,L_model_test_total,G_model_test_total,C_model_test_total,gamma_model_test]...
    = S_2_RLGC(S_model_test_total,freq,len_test);

    RLGC_model_test_total_S = [R_model_test_total,L_model_test_total,G_model_test_total,C_model_test_total];
% end

RLGC_sim_test_total = [R_sim_total(:,index_test),L_sim_total(:,index_test),G_sim_total(:,index_test),C_sim_total(:,index_test)];
axis([0 inf 0 inf])
axis 'auto x'
figure_title = ['RLGC:Solution1 vs Solution2-',num2str(len_test*1e6),'um'];
plot_RLGC_double(freq,RLGC_model_test_total_add,RLGC_model_test_total_S,{'Solution1 ','Solution2'},figure_title,{'-r','--b'});
axis([0 inf 0 inf])
axis 'auto x'


gamma_model_test_add = RLGC_2_gamma( RLGC_model_test_total_add,freq);
gamma_model_test_S = RLGC_2_gamma( RLGC_model_test_total_S,freq);
figure_title = ['alpha and beta: Solution1 vs Solution2-',num2str(len_test*1e6),'um'];
[Err_alpha,Err_beta ]=plot_gamma_double(freq,gamma_model_test_add,gamma_model_test_S ,{'Solution1','Solution2'},figure_title,{'-r','--b'} );
disp_alpha_beta_err( Err_alpha,Err_beta,'Error of alpha & beta' );

% RLGC_sim_test_total = [R_sim_total(:,index_test),L_sim_total(:,index_test),G_sim_total(:,index_test),C_sim_total(:,index_test)];
% axis([0 inf 0 inf])
% axis 'auto x'
% figure_title = ['RLGC: sim vs model-',num2str(len_test*1e6),'um'];
% plot_RLGC_double(freq,RLGC_sim_test_total,RLGC_model_test_total,{'sim-total','model-total'},figure_title,{'-r','--b'});
% axis([0 inf 0 inf])
% axis 'auto x'
% 
% 
% 
% gamma_sim = alpha_sim_total(:,index_test)+1i*beta_sim_total(:,index_test) ;
% figure_title = ['alpha and beta: sim vs model-',num2str(len_test*1e6),'um'];
% [Err_alpha,Err_beta ]=plot_gamma_double(freq,gamma_sim,gamma_model_test,{'sim','model'},figure_title,{'-r','--b'} );
% disp_alpha_beta_err( Err_alpha,Err_beta,'Error of alpha & beta' );

   
    




