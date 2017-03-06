function plot_RLGC0123_scalable( scalable_model )

if strcmp(scalable_model.field,'width')
    x_label = 'Width [\mum]';
end

if strcmp(scalable_model.field,'space')
    x_label = 'Space [\mum]';
end

y_lable_unit = {'[\Omega/m]','[H/m]','[S/m]','[F/m]'};
class = {'R','L','G','C'};

for k =0:1:3
    figure
    for m=1:4
        subplot(2,2,m)
        hold on
        plot(scalable_model.cfit_struct(4*k+m).cfit,(scalable_model.field_data_interp)',...
            (scalable_model.RLGC_0123_interp(4*k+m,:))','g*')
        plot(scalable_model.field_data,(scalable_model.RLGC_0123(4*k+m,:))','ob')
        legend('interped data','fitted curve','origin data')
        xlabel(x_label);
        ylabel([class{k+1},num2str(m-1),' ',y_lable_unit{k+1}])
        axis([0 inf 0 inf])
        axis 'auto x'
        grid on
        grid minor
        hold off
    end
    suptitle([class{k+1},'0123',':','fitted curve'])
end
end

