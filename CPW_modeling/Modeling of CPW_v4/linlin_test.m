clc;clear;close all
dbstop if error;

% TSMC65nm_msline;
% s_params = permute(S,[2 3 1]);
% freq = f';
% len =100e-6;

l2w4s4_file = './S_parameters_sim/L100_500G.csv';
%csvwrite writes a maximum of five significant digits. If you need greater precision, use dlmwrite with a precision argument.
freq_unit = 'GHz';
zero_freq = 0;% dont't deal 0GHz
freq_max = 500e9;
freq_min = 0.5e9;
% len =str2double(cell2mat(regexp(l2w4s4_file,'\d{2,3}', 'match')));
len = 100;
num_pi = ceil(len/50);
len = len *1e-6;
% the unit is different with doctor Fu£¬doctor Fu use cm as the unit of the length
[ s_params,freq] = hfss_csv_2_sparams(l2w4s4_file,zero_freq,freq_unit);
if max(freq)< freq_max || min(freq)>freq_min
    error('max(freq)< freq_max || min(freq)>freq_min');
end
s_params = s_params(:,:,freq<=freq_max & freq>=freq_min );
freq = freq(freq<=freq_max & freq>=freq_min );

%% extract the RLGC  
[R,L,G,C,gamma] = S_2_RLGC(s_params,freq,len); % the unit length is meter!
figure
plot(freq,R);
% R(740:1000) =R(740); 
L_omega = 2*pi.*freq.*L;
C_omega = 2*pi.*freq.*C;

Z_equal = R+1i.*L_omega+1./(G+1i.*C_omega);


deta_len =1e-6;
num_deta = len/deta_len;

R_deta = R*deta_len;
L_deta = L*deta_len;
G_deta = G*deta_len;
C_deta = C*deta_len;
L_deta_omega = 1i*2*pi.*freq.*L_deta;
C_deta_omega = 1i*2*pi.*freq.*C_deta;

ABCD= zeros(2,2,length(freq));
for k =1:length(freq)
    ABCD(:,:,k) = ([1,R_deta(k)+L_deta_omega(k);0,1]*[1,0;C_deta_omega(k)+G_deta(k),1])^num_deta;
end

Y_param = abcd2y(ABCD);
Y11 = reshape(Y_param(1,1,:),length(freq),[]);
R_equal =real(1./Y11);
L_equal =imag(1./Y11)./(2*pi*freq);
% R_parallel =

% figure
% plot(freq,R,freq,R_equal);
% legend('R','R_equal')
% grid on
% grid minor


figure
[ax,p1,p2]=plotyy(freq,R,freq,R_equal);
xlabel(ax(1),'freq') % label x-axis
ylabel(ax(1),'R') % label left y-axis
ylabel(ax(2),'R_equal') % label right y-axis
grid(ax(1),'minor')
hold off

figure
[ax,p1,p2]=plotyy(freq,L,freq,L_equal);
xlabel(ax(1),'freq') % label x-axis
ylabel(ax(1),'L') % label left y-axis
ylabel(ax(2),'L_equal') % label right y-axis
grid(ax(1),'minor')
hold off

