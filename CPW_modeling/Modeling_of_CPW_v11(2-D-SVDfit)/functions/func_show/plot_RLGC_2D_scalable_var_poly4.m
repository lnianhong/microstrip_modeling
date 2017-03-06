function  plot_RLGC_2D_scalable_var_poly4( RLGC_0123_mat,coef_2D,Width_array,Space_array,var_str,index )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
if strcmp(var_str,'space')
    RLGC_0123_all = permute(RLGC_0123_mat(:,index,:),[3,1,2]);
    x_str = 'Space [\mum]';
    var = Space_array;
    var_interp = min(Space_array):0.25:max(Space_array);
    
    RLGC_0123_scalable = zeros(16,length(var_interp));
    Space_tmp = repmat(var_interp',1,5).^[4 3 2 1 0];
    Width_tmp = repmat((Width_array(index))',1,5).^[4 3 2 1 0];
    for k = 1:16 % 16 means RLGC0123
        RLGC_0123_scalable(k,:) =( Space_tmp*coef_2D(:,:,k)*(Width_tmp)')';
    end
    cmp = ['Width=',num2str(Width_array(index))];
    
elseif strcmp(var_str,'width')
    RLGC_0123_all = permute(RLGC_0123_mat(index,:,:),[3,2,1]);
    x_str = 'Width [\mum]';
    var = Width_array;
    
    var_interp = min(Width_array):0.25:max(Width_array);
    
    RLGC_0123_scalable = zeros(16,length(var_interp));
    Space_tmp = repmat((Space_array(index))',1,5).^[4 3 2 1 0];
    Width_tmp = repmat(var_interp',1,5).^[4 3 2 1 0];
    for k = 1:16 % 16 means RLGC0123
        RLGC_0123_scalable(k,:) =( Space_tmp*coef_2D(:,:,k)*(Width_tmp)');
    end
    
    cmp = ['Space=',num2str(Space_array(index))];
else
    error('invalid var_str!')
end

R0123_all = RLGC_0123_all(1:4,:);
L0123_all = RLGC_0123_all(5:8,:);
G0123_all = RLGC_0123_all(9:12,:);
C0123_all = RLGC_0123_all(13:16,:);

R0123_all_scalable = RLGC_0123_scalable(1:4,:);
L0123_all_scalable = RLGC_0123_scalable(5:8,:);
G0123_all_scalable = RLGC_0123_scalable(9:12,:);
C0123_all_scalable = RLGC_0123_scalable(13:16,:);

% plot_4_double(x1,y1,x2,y2,legend_text,x_label,y_label,main_title,sty)
plot_4_double(var,R0123_all,...
              var_interp,R0123_all_scalable,...
              {'origin data','fitted curve'},...
              x_str,...
              {'R0 [\Omega/m]','R1 [\Omega/m]','R2 [\Omega/m]','R3 [\Omega/m]'},...
              ['R0123-',cmp, '  Origin VS Fit'],...
              {'or','-g*'});
          
plot_4_double(var,L0123_all,...
              var_interp,L0123_all_scalable,...
              {'origin data','fitted curve'},...
              x_str,...
              {'L0 [H/m]','L1 [H/m]','L2 [H/m]','L3 [H/m]'},...
              ['L0123-',cmp, '  Origin VS Fit'],...
              {'or','-g*'});

plot_4_double(var,G0123_all,...
              var_interp,G0123_all_scalable,...
              {'origin data','fitted curve'},...
              x_str,...
              {'G0 [S/m]','G1 [S/m]','G2 [S/m]','G3 [S/m]'},...
              ['G0123-',cmp, '  Origin VS Fit'],...
              {'or','-g*'}) ;       

plot_4_double(var,C0123_all,...
              var_interp,C0123_all_scalable,...
              {'origin data','fitted curve'},...
              x_str,...
              {'C0 [F/m]','C1 [F/m]','C2 [C/m]','C3 [F/m]'},...
              ['C0123-',cmp, '  Origin VS Fit'],...
              {'or','-g*'});     
% plot_4_single(var,R0123_all,{'R0','R1','R2','R3'},x_str,'Resistance [\Omega/m]',['R0123-',cmp],'-*r');
% plot_4_single(var,L0123_all,{'L0','L1','L2','L3'},x_str,'Inductance [H/m]',['L0123-',cmp],'-*r');
% plot_4_single(var,G0123_all,{'G0','G1','G2','G3'},x_str,'Conductance [S/m]',['G0123-',cmp],'-*r');
% plot_4_single(var,C0123_all,{'C0','C1','C2','C3'},x_str,'Capacitance [F/m]',['C0123-',cmp],'-*r');

end
