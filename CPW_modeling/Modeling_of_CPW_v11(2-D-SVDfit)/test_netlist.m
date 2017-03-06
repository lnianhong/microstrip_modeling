clc;clear;
load('tmp_data/cpw_2D_W4-10_S3_10_scalable.mat')
hspice = 'D:\synopsys\Hspice_C-2009.09\BIN\hspice.exe';
file_name = './hspice_project/test_cpw/test_cpw_Sparam';
cmd = [hspice,' -i ',file_name,'.sp',' -o ',file_name];
dos(cmd)
warning('off')
delete([file_name,'.sc0'])
delete('*.sc0')
delete([file_name,'.st0'])
delete([file_name,'.pa0'])
delete([file_name,'.ic0'])
warning('on')
x = loadsig([file_name,'.ac0']);
freq = evalsig(x,'HERTZ');
S_hspice = zeros(2,2,length(freq));
S_hspice(1,1,:) = complex(evalsig(x,'s11_real'),evalsig(x,'s11_imag'));
S_hspice(1,2,:) = complex(evalsig(x,'s12_real'),evalsig(x,'s12_imag'));
S_hspice(2,1,:) = complex(evalsig(x,'s21_real'),evalsig(x,'s21_imag'));
S_hspice(2,2,:) = complex(evalsig(x,'s22_real'),evalsig(x,'s22_imag'));

width = 4;
space = 4;
len = 200;
op = eval_2Dscalable_svd( width,space,coeffs,[3 3]);
RLGC_0123 = reshape(op',4,4);
num_subckt = 10;
S_matlab = cpw_model_pi_net(freq,RLGC_0123,200e-6,num_subckt);

S_sim = cpw_cell{space-2,width-3}.files_info(round((len-100)/50)).Sparam_i;
plot_Sparam_double_Real_Imag( freq,S_hspice,S_matlab,{'hspice','matlab'},'hspice VS matlab','off');
plot_Sparam_double_Real_Imag( freq,S_hspice,S_sim,{'hspice','simulation'},'hspice VS sim','off');