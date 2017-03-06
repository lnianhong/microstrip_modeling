function [ h ] = plotyy_4(x,y,legend_text,x_label,y_label,main_title)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
h = figure;
for k=1:2:7
    subplot(2,2,floor(k/2)+1);
    hold on
    [ax,p1,p2]=plotyy(x,y(k+1,:),x,y(k,:));
    title(legend_text{floor(k/2)+1});
    xlabel(ax(1),x_label) % label x-axis
    ylabel(ax(1),y_label{1}) % label left y-axis
    ylabel(ax(2),y_label{2}) % label right y-axis
    grid(ax(1),'minor')
    hold off
end
suptitle(main_title)

end

