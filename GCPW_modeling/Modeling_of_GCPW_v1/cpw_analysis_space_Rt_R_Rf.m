% 考虑端口效应，宽度分析
clc;clear;close all
dbstop if error;
len = [150,200,250,300,350];%W ==5
Space_array = [2 3 4 5 6 7 8 9 10];
% Space_array = [2  4  6  8  10];
% Width_array = [4 5];
space_num = length(Space_array);
width = 4;
len_pi = 12.5*1e-6;
cpwmodel = new_cpwmodel();
for m = 1:space_num
    space = Space_array(m);
    files_info  = new_files_info();
    for k = 1:length(len)
%         files_info(k).name=sprintf('./S_parameters_sim/space/S%d/L%dW%dS%d.csv',space,len(k),width,space);
        files_info(k).name=sprintf('../S_parameters_sim/all/L%dW%dS%d.csv',len(k),width,space);
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
    %% basic info of model
    cpwmodel(m).files_info = files_info;
    cpwmodel(m).len = len*1e-6;
    cpwmodel(m).width = width*1e-6;
    cpwmodel(m).space = space*1e-6;
    cpwmodel(m).RLGC_sim = RLGC_sim;
    cpwmodel(m).RLGC_f_sim = RLGC_f_sim;
    cpwmodel(m).RLGC_fit = RLGC_fit;
    cpwmodel(m).RLGC_0123 = RLGC_0123;
    cpwmodel(m).f_fit = f_fit;
    cpwmodel(m).gamma_sim = RLGC_2_gamma( RLGC_sim,freq);
    cpwmodel(m).gamma_fit = RLGC_2_gamma( RLGC_fit,freq);
    cpwmodel(m) = cpwmodel_err(cpwmodel(m));% error of unit length
    cpwmodel(m) = files_model(cpwmodel(m));
    cpwmodel(m) = files_err(cpwmodel(m));
end

RLGC_0123_all = [cpwmodel.RLGC_0123];
R0123_all = reshape(RLGC_0123_all(:,1:4:end),4,[]);
L0123_all = reshape(RLGC_0123_all(:,2:4:end),4,[]);
G0123_all = reshape(RLGC_0123_all(:,3:4:end),4,[]);
C0123_all = reshape(RLGC_0123_all(:,4:4:end),4,[]);
plot_4_single(Space_array,R0123_all,{'R0','R1','R2','R3'},'Space [\mum]','Resistance [\Omega/m]','R0123','-*r');
plot_4_single(Space_array,L0123_all,{'L0','L1','L2','L3'},'Space [\mum]','Inductance [H/m]','L0123','-*r');
plot_4_single(Space_array,G0123_all,{'G0','G1','G2','G3'},'Space [\mum]','Conductance [S/m]','G0123','-*r');
plot_4_single(Space_array,C0123_all,{'C0','C1','C2','C3'},'Space [\mum]','Capacitance [F/m]','C0123','-*r');
%% save the data
recycle('on')
save_name = 'tmp_data/cpwmodels2-10.mat'; 
if exist(save_name,'file')
    delete(save_name);
end
save(save_name,'cpwmodel');

