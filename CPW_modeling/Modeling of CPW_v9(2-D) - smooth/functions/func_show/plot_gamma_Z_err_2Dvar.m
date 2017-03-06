function plot_gamma_Z_err_2Dvar( err_gamma_Z_ave,err_gamma_Z_max,...
                                               Width_array,Space_array,...
                                               var_str,index  )
if strcmp(var_str,'space')
    err_ave = permute(err_gamma_Z_ave(:,index,:),[3 1 2]);
    err_max = permute(err_gamma_Z_max(:,index,:),[3 1 2]);
    x_str = 'Space [\mum]';
    var = Space_array;
    cmp = ['Width=',num2str(Width_array(index))];
elseif strcmp(var_str,'width')
    err_ave = permute(err_gamma_Z_ave(index,:,:),[3 2 1]);
    err_max = permute(err_gamma_Z_max(index,:,:),[3 2 1]);
    x_str = 'Width [\mum]';
    var = Width_array;
    cmp = ['Space=',num2str(Space_array(index))];
else
    error('invalid var_str!')
end

% plot_err_RLGC( err_ave,err_max,var,x_str,['Error of RLGC-Scalable','[',cmp,']'])
plot_err_gamma_Z(err_ave,err_max,var,x_str,['Error of Gamma & Z -Scalable','[',cmp,']'])
end

