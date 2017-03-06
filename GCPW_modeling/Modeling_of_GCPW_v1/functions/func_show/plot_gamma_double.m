function [Err_alpha,Err_beta] = plot_gamma_double(freq,gamma,gamma_model,legend_text,main_title,sty )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
narginchk(5,6);%
% Check the reference impedance
if nargin < 6
    sty = {'-r','--b'};
end
alpha = real(gamma);
beta = imag(gamma);
alpha_model = real(gamma_model);
beta_model = imag(gamma_model);

freq = freq .*1e-9;
h = figure;
subplot(2,2,1)
hold on
plot(freq,alpha,sty{1},freq,alpha_model,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('Frequency [GHz]');
ylabel('\alpha')
grid on
grid minor
hold off


subplot(2,2,2)
hold on
plot(freq,beta,sty{1},freq,beta_model,sty{2});
legend(legend_text{1},legend_text{2});
xlabel('Frequency [GHz]');
ylabel('\beta')
grid on
grid minor
hold off

Err_alpha = abs(1-alpha_model./alpha);
subplot(2,2,3)
hold on
plot(freq,Err_alpha,sty{1});
legend('error of \alpha');
xlabel('Frequency [GHz]');
ylabel('error of \alpha')
grid on
grid minor
hold off

Err_beta = abs(1-beta_model./beta);
subplot(2,2,4)
hold on
plot(freq,Err_beta,sty{1});
legend('error of \beta');
xlabel('Frequency [GHz]');
ylabel('error of \beta')
grid on
grid minor
hold off



suptitle(main_title)



end

