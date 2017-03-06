function [ h] = plot_Sparam_double_Real_Imag( freq,s_params1,s_params2,legend_text,main_title,annotation_switch,sty )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
narginchk(6,7);%
% Check the reference impedance
if nargin < 7
    sty = {'-r','--b'};
end


S11_1_R = real(reshape(s_params1(1,1,:),[],1));
S12_1_R = real(reshape(s_params1(1,2,:),[],1));
% S21_1_R = real(reshape(s_params1(2,1,:),[],1));
% S22_1_R = real(reshape(s_params1(2,2,:),[],1));

S11_1_I = imag(reshape(s_params1(1,1,:),[],1));
S12_1_I = imag(reshape(s_params1(1,2,:),[],1));
% S21_1_I = imag(reshape(s_params1(2,1,:),[],1));
% S22_1_I = imag(reshape(s_params1(2,2,:),[],1));

S11_2_R = real(reshape(s_params2(1,1,:),[],1));
S12_2_R = real(reshape(s_params2(1,2,:),[],1));
% S21_2_R = real(reshape(s_params2(2,1,:),[],1));
% S22_2_R = real(reshape(s_params2(2,2,:),[],1));

S11_2_I = imag(reshape(s_params2(1,1,:),[],1));
S12_2_I = imag(reshape(s_params2(1,2,:),[],1));
% S21_2_I = imag(reshape(s_params2(2,1,:),[],1));
% S22_2_I = imag(reshape(s_params2(2,2,:),[],1));
if strcmp(annotation_switch,'on')
    Err_S11_R_max = max(abs(1-S11_2_R./S11_1_R));
    Err_S11_R_ave = mean(abs(1-S11_2_R./S11_1_R));
    Err_S12_R_max = max(abs(1-S12_2_R./S12_1_R));
    Err_S12_R_ave = mean(abs(1-S12_2_R./S12_1_R));
    Err_S11_I_max = max(abs(1-S11_2_I./S11_1_I));
    Err_S11_I_ave = mean(abs(1-S11_2_I./S11_1_I));
    Err_S12_I_max = max(abs(1-S12_2_I./S12_1_I));
    Err_S12_I_ave = mean(abs(1-S12_2_I./S12_1_I));
end



h = figure ;
hold on
subplot(2,2,1)
plot(freq,S11_1_R,sty{1},freq,S11_2_R,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('freq/Hz');
ylabel('Real(S11/S22)')
if strcmp(annotation_switch,'on')
    dim = [0.2 0.4 0.3 0.3];
    str = {['ave error:',num2str(100*Err_S11_R_ave),'%'],...,
        ['max error:',num2str(100*Err_S11_R_max),'%']};
    annotation('textbox',dim,'String',str,'FitBoxToText','on');
end
grid on
grid minor
hold off

hold on
subplot(2,2,2)
plot(freq,S11_1_I,sty{1},freq,S11_2_I,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('freq/Hz');
ylabel('Imag(S11/S22)')

if strcmp(annotation_switch,'on')
    dim = [0.2 0.4 0.3 0.3];
    str = {['ave error:',num2str(100*Err_S11_I_ave),'%'],...,
        ['max error:',num2str(100*Err_S11_I_max),'%']};
    annotation('textbox',dim,'String',str,'FitBoxToText','on');
end

grid on
grid minor
hold off

hold on
subplot(2,2,3)
plot(freq,S12_1_R,sty{1},freq,S12_2_R,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('freq/Hz');
ylabel('Real(S12/S21)')
if strcmp(annotation_switch,'on')
    dim = [0.2 0.4 0.3 0.3];
    str = {['ave error:',num2str(100*Err_S12_R_ave),'%'],...,
        ['max error:',num2str(100*Err_S12_R_max),'%']};
    annotation('textbox',dim,'String',str,'FitBoxToText','on');
end
grid on
grid minor
hold off

hold on
subplot(2,2,4)
plot(freq,S12_1_I,sty{1},freq,S12_2_I,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('freq/Hz');
ylabel('Imag(S12/S21)')
if strcmp(annotation_switch,'on')
    dim = [0.8 0.1 0.3 0.3];
    str = {['ave error:',num2str(100*Err_S12_I_ave),'%'],...,
        ['max error:',num2str(100*Err_S12_I_max),'%']};
    annotation('textbox',dim,'String',str,'FitBoxToText','on');
end
grid on
grid minor
hold off

suptitle(main_title)

end

