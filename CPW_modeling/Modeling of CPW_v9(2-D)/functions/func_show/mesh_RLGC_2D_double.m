function mesh_RLGC_2D_double( RLGC_0123_mat,coef_2D,Width_array,Space_array,index)
%index : 1:4 R0-R3 5-8:L0:L3
%   Detailed explanation goes here
linesty = {'none','-'};
Markersty = {'o','none'};

Width_interp =min(Width_array):0.25:max(Width_array);
Space_interp =min(Space_array):0.25:max(Space_array);

RLGC_0123_mat2 = zeros(length(Space_interp),length(Width_interp),16);
Space_tmp = repmat(Space_interp',1,4).^[3 2 1 0];
Width_tmp = repmat(Width_interp',1,4).^[3 2 1 0];
for k = 1:16 % 16 means RLGC0123
    RLGC_0123_mat2(:,:,k) = Space_tmp*coef_2D(:,:,k)*(Width_tmp)';
end



zlabel_str = {'Resistance [\Omega/m]','Inductance [H/m]','Conductance [S/m]','Capacitance [F/m]'};
legend_str = 'RLGC';
for ii = 1:length(index)
    k = index(ii);
    figure
    mesh(Width_interp,Space_interp,RLGC_0123_mat2(:,:,k),'LineStyle',linesty{2},'Marker',Markersty{2});
    hold on
    mesh(Width_array,Space_array,RLGC_0123_mat(:,:,k),'LineStyle',linesty{1},'Marker',Markersty{1});
    xlabel('Width [\mum]');
    ylabel('Space [\mum]');
    zlabel(zlabel_str{ceil(k/4)});
    title([legend_str(ceil(k/4)),num2str(rem(k-1,4)),'  Origin VS Fit']);
    legend([legend_str(ceil(k/4)),num2str(rem(k-1,4))]);
    grid minor
    hold off
end
end


% function mesh_RLGC_2D_double( Width_array,Space_array,RLGC_0123_mat,...
%                               Width_array2,Space_array2,RLGC_0123_mat2,...
%                               index,linesty,Markersty)
% %index : 1:4 R0-R3 5-8:L0:L3
% %   Detailed explanation goes here
% narginchk(7,9);%
% % Check the reference impedance
% if nargin < 8
%     linesty = {'none','-'};
% end
% if nargin < 9
%     Markersty = {'o','*'};
% end
%
%
% zlabel_str = {'Resistance [\Omega/m]','Inductance [H/m]','Conductance [S/m]','Capacitance [F/m]'};
% legend_str = 'RLGC';
% for ii = 1:length(index)
%     k = index(ii);
%     figure
%     hold on
%     mesh(Width_array,Space_array,RLGC_0123_mat(:,:,k),'LineStyle',linesty{1},'Marker',Markersty{1});
%     mesh(Width_array2,Space_array2,RLGC_0123_mat2(:,:,k),'LineStyle',linesty{1},'Marker',Markersty{2});
%     xlabel('Width [\mum]');
%     ylabel('Space [\mum]');
%     zlabel(zlabel_str{ceil(k/4)});
%     title([legend_str(ceil(k/4)),num2str(rem(k-1,4)),'Origin VS Fit']);
%     legend([legend_str(ceil(k/4)),num2str(rem(k-1,4))]);
%     hold off
% end
% end
