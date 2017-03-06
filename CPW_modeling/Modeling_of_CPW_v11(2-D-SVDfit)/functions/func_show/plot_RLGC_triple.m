function [ h] = plot_RLGC_triple(freq,RLGC1,RLGC2,RLGC3,legend_text,main_title,sty)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
narginchk(6,7);%
% Check the reference impedance
if nargin < 7
    sty = {'-r','--b','.-g'};
end
R1 = RLGC1(:,1);
L1 = RLGC1(:,2);
G1 = RLGC1(:,3);
C1 = RLGC1(:,4);
R2 = RLGC2(:,1);
L2 = RLGC2(:,2);
G2 = RLGC2(:,3);
C2 = RLGC2(:,4);
R3 = RLGC3(:,1);
L3 = RLGC3(:,2);
G3 = RLGC3(:,3);
C3 = RLGC3(:,4);


freq = freq .*1e-9;
h = figure;
subplot(2,2,1)
hold on
plot(freq,R1,sty{1},freq,R2,sty{2},freq,R3,sty{3});
legend(legend_text{1},legend_text{2},legend_text{3});
xlabel('Frequency [GHz]');
ylabel('Resistance [\Omega/m]')
% dim = [0.6 0.9 0.4 0.2 ];
% str = {['Err_max:',num2str(Err_R_max*100,'%.2f'),'%'],'from 1 to 10'};
% annotation('textbox',dim,'String',str,'FitBoxToText','on');
grid on
grid minor
hold off


subplot(2,2,2)
hold on
plot(freq,L1,sty{1},freq,L2,sty{2},freq,L3,sty{3});
legend(legend_text{1},legend_text{2},legend_text{3});
xlabel('Frequency [GHz]');
ylabel('Inductance [H/m]')
grid on
grid minor
hold off

subplot(2,2,3)
hold on
plot(freq,G1,sty{1},freq,G2,sty{2},freq,G3,sty{3});
legend(legend_text{1},legend_text{2},legend_text{3});
xlabel('Frequency [GHz]');
ylabel('Conductance [S/m]')
grid on
grid minor
hold off

subplot(2,2,4)
hold on
plot(freq,C1,sty{1},freq,C2,sty{2},freq,C3,sty{3});
legend(legend_text{1},legend_text{2},legend_text{3});
xlabel('Frequency [GHz]');
ylabel('Capacitance [F/m]')
grid on
grid minor
axis([0 inf 0 inf])
axis 'auto x'
hold off



suptitle(main_title)



end



