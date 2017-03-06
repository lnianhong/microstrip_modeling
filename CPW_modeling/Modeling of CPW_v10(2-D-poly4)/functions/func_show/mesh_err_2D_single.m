function mesh_err_2D_single( Width_array,Space_array,err,title_str,linesty,Markersty)
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


zlabel_str = title_str;

figure
mesh(Width_array,Space_array,err,'LineStyle',linesty,'Marker',Markersty);
xlabel('Width [\mum]');
ylabel('Space [\mum]');
zlabel(zlabel_str);
title(title_str);
grid minor

end
% figure
% mesh(Width_array,Space_array,RLGC_0123_mat(:,:,1),'LineStyle','-','Marker','*');
% xlabel('Width [\mum]');
% ylabel('Space [\mum]');
% zlabel('Resistance [\Omega/m]');
% legend('R0')
