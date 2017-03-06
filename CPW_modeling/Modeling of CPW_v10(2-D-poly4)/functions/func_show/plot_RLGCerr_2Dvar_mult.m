function plot_RLGCerr_2Dvar_mult( err, Width_array,Space_array,var_str,title_str)
if strcmp(var_str,'space')
    x_str = 'Space [\mum]';
    var = Space_array;
    cmp = cell(length(Width_array),1);
    for k=1:length(Width_array)
        cmp{k} = ['Width=',num2str(Width_array(k))];
    end
elseif strcmp(var_str,'width')
    x_str = 'Width [\mum]';
    var = Width_array;
    cmp = cell(length(Space_array),1);
    for k=1:length(Space_array)
        cmp{k} = ['Space=',num2str(Space_array(k))];
    end
    err = permute(err,[2,1,3]);
else
    error('invalid var_str!')
end

% plot_err_RLGC( err_ave,err_max,var,x_str,['Error of RLGC-Scalable','[',cmp,']'])

str = {'R','L','G','C'};
figure
for k=1:4
    subplot(2,2,k);
    hold on
    plot(var,err(:,:,k),'-*')
    ylabel(['Error of ',str{k}])
    xlabel(x_str)
    legend(cmp)
    grid on
    grid minor
%     axis([1 10 0 0.1])
    axis 'auto x'
    hold off
end
suptitle(title_str)

end

