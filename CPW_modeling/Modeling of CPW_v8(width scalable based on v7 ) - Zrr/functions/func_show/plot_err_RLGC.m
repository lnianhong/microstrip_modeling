function plot_err_RLGC( ave_err,max_err,var,str_xlabel,maintitle )

str = {'R','L','G','C'};
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

