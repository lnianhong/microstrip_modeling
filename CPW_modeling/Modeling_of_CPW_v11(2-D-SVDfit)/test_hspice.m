clc;clear;
hspice = 'D:\synopsys\Hspice_C-2009.09\BIN\hspice.exe';
file_name = 'hspice_project/test_unit_Sparam/test_unit_Sparam';

cmd = [hspice,' -i ',file_name,'.sp',' -o ',file_name];
dos(cmd)
x = loadsig([file_name,'.ac0']);
freq = evalsig(x,'HERTZ');
S_hspice = zeros(2,2,length(freq));
S_hspice(1,1,:) = complex(evalsig(x,'s11_real'),evalsig(x,'s11_imag'));
S_hspice(1,2,:) = complex(evalsig(x,'s12_real'),evalsig(x,'s12_imag'));
S_hspice(2,1,:) = complex(evalsig(x,'s21_real'),evalsig(x,'s21_imag'));
S_hspice(2,2,:) = complex(evalsig(x,'s22_real'),evalsig(x,'s22_imag'));
% [~,gamma,Z] = S_2_RLGC(Spara,freq,1,50);
RLGC = repmat([5434 2.97e-7 2.58 1.754e-10],length(freq),1);
S_matlab = RLGC_2_S_unsym( RLGC,freq,1,1);
plot_Sparam_double_Real_Imag( freq,S_hspice,S_matlab,{'hspice','matlab'},'hspice VS matlab','off');

% S11 = S_matlab(1,1,:);
% S11 = reshape(S11,[],1);
% 
% S12 = S_matlab(1,2,:);
% S12 = reshape(S12,[],1);
% 
% S21 = S_matlab(2,1,:);
% S21 = reshape(S21,[],1);
% 
% S22 = S_matlab(2,2,:);
% S22 = reshape(S22,[],1);
% data = [real(S11),imag(S11),real(S12),imag(S21),real(S21),imag(S21),real(S22),imag(S22)];
% 

