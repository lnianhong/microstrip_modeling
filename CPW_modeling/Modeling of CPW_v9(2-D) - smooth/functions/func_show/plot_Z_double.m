function [Err_real_Z,Err_imag_Z] = plot_Z_double(freq,Z,Z_model,legend_text,main_title,sty )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
narginchk(5,6);%
% Check the reference impedance
if nargin < 6
    sty = {'-r','--b'};
end
real_Z = real(Z);
imag_Z = imag(Z);
real_Z_model = real(Z_model);
imag_Z_model = imag(Z_model);

freq = freq .*1e-9;
h = figure;
subplot(2,2,1)
hold on
plot(freq,real_Z,sty{1},freq,real_Z_model,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('Frequency [GHz]');
ylabel('real_Z')
grid on
grid minor
hold off


subplot(2,2,2)
hold on
plot(freq,imag_Z,sty{1},freq,imag_Z_model,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('Frequency [GHz]');
ylabel('imag_Z')
grid on
grid minor
hold off

Err_real_Z = abs(1-real_Z_model./real_Z);
subplot(2,2,3)
hold on
plot(freq,Err_real_Z,sty{1});
legend('error of real_Z');
xlabel('Frequency [GHz]');
ylabel('error of real_Z')
grid on
grid minor
hold off

Err_imag_Z = abs(1-imag_Z_model./imag_Z);
subplot(2,2,4)
hold on
plot(freq,Err_imag_Z,sty{1});
legend('error of imag_Z');
xlabel('Frequency [GHz]');
ylabel('error of imag_Z')
grid on
grid minor
hold off



suptitle(main_title)



end

