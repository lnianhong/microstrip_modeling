function mesh_RLGC_2D_single( Width_array,Space_array,RLGC_0123_mat,index,linesty,Markersty)
%index : 1:4 R0-R3 5-8:L0:L3 
%   Detailed explanation goes here
narginchk(4,6);%
% Check the reference impedance
if nargin < 5
    linesty = '-';
end
if nargin < 6
    Markersty = '*';
end


zlabel_str = {'Resistance [\Omega/m]','Inductance [H/m]','Conductance [S/m]','Capacitance [F/m]'};
legend_str = 'RLGC';
for ii = 1:length(index)
    k = index(ii);
    figure
    mesh(Width_array,Space_array,RLGC_0123_mat(:,:,k),'LineStyle',linesty,'Marker',Markersty);
    xlabel('Width [\mum]');
    ylabel('Space [\mum]');
    zlabel(zlabel_str{ceil(k/4)});
    grid minor
    legend([legend_str(ceil(k/4)),num2str(rem(k-1,4))]);
end
end
% figure
% mesh(Width_array,Space_array,RLGC_0123_mat(:,:,1),'LineStyle','-','Marker','*');
% xlabel('Width [\mum]');
% ylabel('Space [\mum]');
% zlabel('Resistance [\Omega/m]');
% legend('R0')
