function [L_0123,R_0123,G_123,C_0123 ] = cpw_model( f_123,freq,R,L,G,C,num_RL_net)
% each section use three R-L NETWORKS  to model the cpw
% input: f_123,freq,R,L,G,C are vectors
%
narginchk(6,7);%
% Check the reference impedance
if nargin < 7
    num_RL_net = 3;
end

if (f_123(2) / f_123(1) < 10) || (f_123(3) / f_123(2) < 10) 
    if (f_123(2) / f_123(1) < 3.3) || (f_123(3) / f_123(2) < 3.3)
        warning('The corner frequencies do not satisfied with the omega2/omega1 >=3.3 and omega3/omega2 >=3.3 ')
    else
        warning('The corner frequencies do not satisfied with the omega2/omega1 >=10 and omega3/omega2 >=10 ')
    end
    
end



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

RL_coef = [0    1   0.5                 0                   0;
           0    1   1                   0.5                 0;
           0    1   1                   1                   0.5;
           1    0   0.5./omega_123(1)   1./omega_123(2)     1./omega_123(3);
           1    0   0                   0.5./omega_123(2)   1./omega_123(3)];
R_omega123_L_omega12 = [R_omega123;L_omega123(1:2)];
L0_R0123 = RL_coef\R_omega123_L_omega12;

L_123 = L0_R0123(3:5)./omega_123; % L_i = R_i/omega_i

L_0123 = [L0_R0123(1);L_123];
R_0123 = L0_R0123(2:5);


%% Shunt Model
G_omega123 = interp1(freq,G,f_123,'linear');
C_omega123 = interp1(freq,C,f_123,'linear');

G_1 = 2*G_omega123(1);
G_2 = 2*(G_omega123(2)-G_1);
G_3 = 2*(G_omega123(3)-G_1-G_2);

G_123 = [G_1;G_2;G_3];
C_123 = G_123 ./omega_123;
C_0 = C_omega123(3) - C_123(3) ./ 2;
C_0123 = [C_0;C_123];



end

