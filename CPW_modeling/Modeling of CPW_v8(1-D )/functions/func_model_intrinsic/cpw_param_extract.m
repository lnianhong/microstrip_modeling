function [RLGC_0123] = cpw_param_extract( f_123,freq,RLGC,flag_RLGC,num_RL_net)
% each section use three R-L NETWORKS  to model the cpw
% use the given parameters to calculate the RLGC0123
% input: f_123,freq,R,L,G,C are vectors
% output: R_0123,L_0123,G_0123,C_0123
% this function is called by fit_RLGC();
narginchk(4,5);%
% Check the reference impedance
if nargin < 5
    num_RL_net = 3;
end

R = RLGC(:,1);
L = RLGC(:,2);
G = RLGC(:,3);
C = RLGC(:,4);
% if (f_123(2) / f_123(1) < 10) || (f_123(3) / f_123(2) < 10)
%     if (f_123(2) / f_123(1) < 3.3) || (f_123(3) / f_123(2) < 3.3)
%         warning('The corner frequencies do not satisfied with the omega2/omega1 >=3.3 and omega3/omega2 >=3.3 ')
%     else
%         warning('The corner frequencies do not satisfied with the omega2/omega1 >=10 and omega3/omega2 >=10 ')
%     end
%
% end



omega_123 = f_123 * 2 * pi;
%% series model
%   three sections are used
% AX = B X = A\B

% linear interpolation (table lookup)
R_omega123 = interp1(freq,R,f_123,'linear');
L_omega123 = interp1(freq,L,f_123,'linear');

if sum(isnan(R_omega123)) % judge if there ara NaNs in R_omage123
    error('error f_123 out of the scale,,pay attention to the unit! see the help of function interp1()');
end
if sum(isnan(L_omega123))
    error('error f_123 out of the scale,see the help of function interp1()');
end

if (num_RL_net ~= 3)
    error( 'Only 3 R-L NETWORKS in one section is supported!   ');
end
R_0123 = zeros(num_RL_net+1,1);
L_0123 = zeros(num_RL_net+1,1);
G_0123 = zeros(num_RL_net+1,1);
C_0123 = zeros(num_RL_net+1,1);
if strcmp(flag_RLGC,'RL') || strcmp(flag_RLGC,'RLGC')
    
    RL_coef = [ 0    1   0.5                 0                   0;
        0    1   1                   0.5                 0;
        0    1   1                   1                   0.5;
        1    0   0.5./omega_123(1)   1./omega_123(2)     1./omega_123(3);
        1    0   0                   0.5./omega_123(2)   1./omega_123(3)];
    R_omega123_L_omega12 = [R_omega123;L_omega123(1:2)];
    L0_R0123 = RL_coef\R_omega123_L_omega12;
    
    L_123 = L0_R0123(3:5)./omega_123; % L_i = R_i/omega_i
    
    L_0123 = [L0_R0123(1);L_123];
    R_0123 = L0_R0123(2:5);
end

%% Shunt Model


% if strcmp(flag,'GC') || strcmp(flag,'RLGC')
%     G_omega123 = interp1(freq,G,f_123,'linear');
%     C_omega123 = interp1(freq,C,f_123,'linear');
%
%     G_0 = 0;
%     G_1 = 2*G_omega123(1);
%     G_2 = 2*(G_omega123(2)-G_1);
%     G_3 = 2*(G_omega123(3)-G_1-G_2);
%
%     G_0123 = [G_0;G_1;G_2;G_3];
%
%     C_123 = G_0123(2:4) ./omega_123;
%     C_0 = C_omega123(3) - C_123(3) ./ 2;
%     C_0123 = [C_0;C_123];
%
% end
if strcmp(flag_RLGC,'GC') || strcmp(flag_RLGC,'RLGC')
    G_omega123 = interp1(freq,G,f_123,'linear');
    C_omega123 = interp1(freq,C,f_123,'linear');
    
    GC_coef = [ 0    1   0.5                 0                   0;
                0    1   1                   0.5                 0;
                0    1   1                   1                   0.5;
                1    0   0.5./omega_123(1)   1./omega_123(2)     1./omega_123(3);
                1    0   0                   0.5./omega_123(2)   1./omega_123(3)];
    G_omega123_C_omega12 = [G_omega123;C_omega123(1:2)];
    C0_G0123 = GC_coef\G_omega123_C_omega12;
    
    C_123 = C0_G0123(3:5)./omega_123; % L_i = R_i/omega_i
    
    C_0123 = [C0_G0123(1);C_123];
    G_0123 = C0_G0123(2:5);
end


RLGC_0123 = [R_0123,L_0123,G_0123,C_0123];
end

