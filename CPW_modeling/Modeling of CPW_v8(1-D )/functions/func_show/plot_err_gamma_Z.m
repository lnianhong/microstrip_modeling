function plot_err_gamma_Z( ave_err,max_err,var,str_xlabel,maintitle )

str = {'alpha','beta','real(Z)','imag(Z)'};
% ave_err = [err_struct.ave_err_alpha;...
%            err_struct.ave_err_beta;...
%            err_struct.ave_Z_real;...
%            err_struct.ave_Z_imag];
%        
% max_err = [err_struct.max_err_alpha;...
%            err_struct.max_err_beta;...
%            err_struct.max_Z_real;...
%            err_struct.max_Z_imag];
figure
for k=1:4
    subplot(2,2,k);
    hold on
    plot(var,ave_err(k,:),'-*')
    plot(var,max_err(k,:),'--o')
    ylabel(['Error of ',str{k}])
    xlabel(str_xlabel)
    legend('ave','max')
    grid on
    grid minor
    hold off
end
suptitle(maintitle)


end

