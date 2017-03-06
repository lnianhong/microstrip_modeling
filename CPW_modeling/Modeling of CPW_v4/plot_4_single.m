function [ h ] = plot_4_single(x,y1,legend_text,x_label,y_label,main_title,sty)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
narginchk(6,7);%
% Check the reference impedance
if nargin < 7
    sty = '-r';
end
h = figure;
for k=1:4
    subplot(2,2,k)
    hold on
    plot(x,y1(k,:),sty);
    legend(legend_text{k});
    xlabel(x_label);
    ylabel(y_label)
    grid on
    grid minor
    hold off
end
suptitle(main_title)


end

