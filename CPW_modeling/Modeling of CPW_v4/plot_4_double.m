function [ h] = plot_4_double(x,y1,y2,legend_text,x_label,y_label,main_title,sty)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
narginchk(7,8);%
% Check the reference impedance
if nargin < 8
    sty = {'-r','--b'};
end
h = figure;
for k=1:4
    subplot(2,2,k)
    hold on
    plot(x,y1(k,:),sty{1},x,y2(k,:),sty{2});
    legend(legend_text{1},legend_text{2});
    xlabel(x_label);
    ylabel(y_label{k})
    grid on
    grid minor
    hold off
end
suptitle(main_title)

end



