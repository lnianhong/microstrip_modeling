clc;clear;close all ;
dbstop if error;
data = load('tmp_data/cpwmodelw4-12.mat');
cpwmodel_all =data.cpwmodel; clear data;
cpwmodel_w =cpwmodel_all(2:7); 
Width_array = [cpwmodel_w.width]; 

% Width_array_interp = min(Width_array):0.1*1e-6:max(Width_array);
RLGC_0123_all = [cpwmodel_w.RLGC_0123];
R0123_width = reshape(RLGC_0123_all(:,1:4:end),4,[]);
L0123_width = reshape(RLGC_0123_all(:,2:4:end),4,[]);
G0123_width = reshape(RLGC_0123_all(:,3:4:end),4,[]);
C0123_width = reshape(RLGC_0123_all(:,4:4:end),4,[]);
% plot_4_single(Width_array,R0123_width,{'R0','R1','R2','R3'},'Width [\mum]','Resistance [\Omega/m]','R0123','-*r');
% plot_4_single(Width_array,L0123_width,{'L0','L1','L2','L3'},'Width [\mum]','Inductance [H/m]','L0123','-*r');
% plot_4_single(Width_array,G0123_width,{'G0','G1','G2','G3'},'Width [\mum]','Conductance [S/m]','G0123','-*r');
% plot_4_single(Width_array,C0123_width,{'C0','C1','C2','C3'},'Width [\mum]','Capacitance [F/m]','C0123','-*r');

R = new_RLGC0123_scalable_model();
R.field = 'width';
R.field_data = Width_array;

Width_array_interp = min(Width_array):0.1*1e-6:max(Width_array);
RLGC0123_width = [R0123_width;L0123_width;G0123_width;C0123_width];
RLGC0123_width_interp = interp_matrix( Width_array,RLGC0123_width,Width_array_interp,'array','pchip');
R.field_data_interp = Width_array_interp;
R.RLGC_0123 = RLGC0123_width
R.RLGC_0123_interp = RLGC0123_width_interp;


[ fit_result] = fit_RLGC0123( Width_array_interp,RLGC0123_width_interp);


for m=1:16
    figure
    hold on 
    plot(fit_result(m).cfit,Width_array_interp',RLGC0123_width_interp(m,:)','g*')
    plot(Width_array,RLGC0123_width(m,:)','ob')
    axis([0 inf 0 inf])
    axis 'auto x' 
    grid on 
    grid minor
    hold off
end





