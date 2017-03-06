function  plot_RLGC_2Dvar( RLGC_0123_mat,Width_array,Space_array,var_str,index )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
if strcmp(var_str,'space')
    RLGC_0123_all = permute(RLGC_0123_mat(:,index,:),[3,1,2]);
    x_str = 'Space [\mum]';
    var = Space_array;
    cmp = ['Width=',num2str(Width_array(index)),'um'];
elseif strcmp(var_str,'width')
    RLGC_0123_all = permute(RLGC_0123_mat(index,:,:),[3,2,1]);
    x_str = 'Width [\mum]';
    var = Width_array;
    cmp = ['Space=',num2str(Space_array(index)),'um'];
else
    error('invalid var_str!')
end

R0123_all = RLGC_0123_all(1:4,:);
L0123_all = RLGC_0123_all(5:8,:);
G0123_all = RLGC_0123_all(9:12,:);
C0123_all = RLGC_0123_all(13:16,:);

plot_4_single(var,R0123_all,{'R0','R1','R2','R3'},x_str,'Resistance [\Omega/m]',['R0123-',cmp],'-*r');
plot_4_single(var,L0123_all,{'L0','L1','L2','L3'},x_str,'Inductance [H/m]',['L0123-',cmp],'-*r');
plot_4_single(var,G0123_all,{'G0','G1','G2','G3'},x_str,'Conductance [S/m]',['G0123-',cmp],'-*r');
plot_4_single(var,C0123_all,{'C0','C1','C2','C3'},x_str,'Capacitance [F/m]',['C0123-',cmp],'-*r');

end
% RLGC_0123_all = permute(RLGC_0123_mat(:,1,:),[3,1,2]);
% R0123_all = RLGC_0123_all(1:4,:);
% L0123_all = RLGC_0123_all(5:8,:);
% G0123_all = RLGC_0123_all(9:12,:);
% C0123_all = RLGC_0123_all(13:16,:);
% 
% plot_4_single(Space_array,R0123_all,{'R0','R1','R2','R3'},'Width [\mum]','Resistance [\Omega/m]','R0123','-*r');
% plot_4_single(Space_array,L0123_all,{'L0','L1','L2','L3'},'Width [\mum]','Inductance [H/m]','L0123','-*r');
% plot_4_single(Space_array,G0123_all,{'G0','G1','G2','G3'},'Width [\mum]','Conductance [S/m]','G0123','-*r');
% plot_4_single(Space_array,C0123_all,{'C0','C1','C2','C3'},'Width [\mum]','Capacitance [F/m]','C0123','-*r');

