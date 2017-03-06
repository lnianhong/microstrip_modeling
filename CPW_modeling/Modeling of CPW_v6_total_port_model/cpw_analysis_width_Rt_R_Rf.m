% 考虑端口效应，宽度分析
clc;clear;close all
dbstop if error;
addpath('./function')
len = [150,200,250,300,350];%W ==5
Width_array = [4 5 6 7 8];
width_num = length(Width_array);
space = 4;
cpw_model = new_cpwmodel();

for m = 1:width_num
    width = Width_array(m);
    
    files_info  = new_files_info();
    for k = 1:length(len)
        files_info(k).name=sprintf('./S_parameters_sim/width/W%d/L%dW%dS%d.csv',width,len(k),width,space);
        files_info(k).length = len(k)*1e-6;
        files_info(k).width = width;
        files_info(k).space = space;
    end
    [ files_info,RLGC_sim,RLGC_f_sim] = reg_RLGC( files_info);
    freq = files_info(1).freq;
    [ RLGC_fit,RLGC_0123,f_fit ] = RLGC_2_0123( RLGC_sim,freq);
%     plot_RLGC_double(freq,RLGC_sim,RLGC_fit,{'sim','fit'},'RLGC: sim vs fit',{'-r','--b'});
    
    cpw_model(m).files_info = files_info;
    cpw_model(m).len = len;
    cpw_model(m).width = width;
    cpw_model(m).space = space;
    cpw_model(m).RLGC_sim = RLGC_sim;
    cpw_model(m).RLGC_f_sim = RLGC_f_sim;
    cpw_model(m).RLGC_fit = RLGC_fit;
    cpw_model(m).RLGC_0123 = RLGC_0123;
    cpw_model(m).f_fit = f_fit;
end

RLGC_0123_all = [cpw_model.RLGC_0123];
R0123_all = reshape(RLGC_0123_all(:,1:4:end),4,[]);
L0123_all = reshape(RLGC_0123_all(:,2:4:end),4,[]);
G0123_all = reshape(RLGC_0123_all(:,3:4:end),4,[]);
C0123_all = reshape(RLGC_0123_all(:,4:4:end),4,[]);
plot_4_single(Width_array,R0123_all,{'R0','R1','R2','R3'},'Width [\mum]','Resistance [\Omega/m]','R0123','-*r');
plot_4_single(Width_array,L0123_all,{'L0','L1','L2','L3'},'Width [\mum]','Inductance [H/m]','L0123','-*r');
plot_4_single(Width_array,G0123_all,{'G0','G1','G2','G3'},'Width [\mum]','Conductance [S/m]','G0123','-*r');
plot_4_single(Width_array,C0123_all,{'C0','C1','C2','C3'},'Width [\mum]','Capacitance [F/m]','C0123','-*r');
