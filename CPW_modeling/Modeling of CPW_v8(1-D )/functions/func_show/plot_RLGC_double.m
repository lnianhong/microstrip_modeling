function [ h] = plot_RLGC_double(freq,RLGC,RLGC_fit,legend_text,main_title,sty)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
narginchk(5,6);%
% Check the reference impedance
if nargin < 6
    sty = {'-r','--b'};
end
R = RLGC(:,1);
L = RLGC(:,2);
G = RLGC(:,3);
C = RLGC(:,4);

R_fit = RLGC_fit(:,1);
L_fit = RLGC_fit(:,2);
G_fit = RLGC_fit(:,3);
C_fit = RLGC_fit(:,4);


freq = freq .*1e-9;
h = figure;
subplot(2,2,1)
hold on
plot(freq,R,sty{1},freq,R_fit,sty{2});
legend(legend_text{1},legend_text{2});
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
plot(freq,L,sty{1},freq,L_fit,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('Frequency [GHz]');
ylabel('Inductance [H/m]')
grid on
grid minor
hold off

subplot(2,2,3)
hold on
plot(freq,G,sty{1},freq,G_fit,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('Frequency [GHz]');
ylabel('Conductance [S/m]')
grid on
grid minor
hold off

subplot(2,2,4)
hold on
plot(freq,C,sty{1},freq,C_fit,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('Frequency [GHz]');
ylabel('Capacitance [F/m]')
grid on
grid minor
axis([0 inf 0 inf])
axis 'auto x'
hold off



suptitle(main_title)



end



