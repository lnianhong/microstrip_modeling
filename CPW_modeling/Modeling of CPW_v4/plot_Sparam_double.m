function [ h] = plot_Sparam_double(freq,s_params1,s_params2,legend_text,main_title,sty)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
narginchk(5,6);%
% Check the reference impedance
if nargin < 6
    sty = {'-r','--b'};
end


S11_1 = 20 *log10(abs(reshape(s_params1(1,1,:),[],1)));
S12_1 = 20 *log10(abs(reshape(s_params1(1,2,:),[],1)));
S21_1 = 20 *log10(abs(reshape(s_params1(2,1,:),[],1)));
S22_1 = 20 *log10(abs(reshape(s_params1(2,2,:),[],1)));

S11_2 = 20 *log10(abs(reshape(s_params2(1,1,:),[],1)));
S12_2 = 20 *log10(abs(reshape(s_params2(1,2,:),[],1)));
S21_2 = 20 *log10(abs(reshape(s_params2(2,1,:),[],1)));
S22_2 = 20 *log10(abs(reshape(s_params2(2,2,:),[],1)));

h = figure ;
hold on
subplot(2,2,1)
plot(freq,S11_1,sty{1},freq,S11_2,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('freq/Hz');
ylabel('S11/dB')
grid on
grid minor
hold off

hold on
subplot(2,2,2)
plot(freq,S12_1,sty{1},freq,S12_2,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('freq/Hz');
ylabel('S12/dB')
grid on
grid minor
hold off

hold on
subplot(2,2,3)
plot(freq,S21_1,sty{1},freq,S21_2,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('freq/Hz');
ylabel('S21/dB')
grid on
grid minor
hold off

hold on
subplot(2,2,4)
plot(freq,S22_1,sty{1},freq,S22_2,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('freq/Hz');
ylabel('S22/dB')
grid on
grid minor
hold off

suptitle(main_title)



end

