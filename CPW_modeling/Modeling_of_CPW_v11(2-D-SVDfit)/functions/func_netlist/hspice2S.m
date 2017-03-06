function [ S_hspice,freq ] = hspice2S( sp_file,hspice_path)
narginchk(1,2);%
% Check the reference impedance
if nargin < 2
    hspice_path = 'D:\synopsys\Hspice_C-2009.09\BIN\hspice.exe';
end
file_name = sp_file(1:end-3);
% file_name = './hspice_project/test_cpw/test_cpw_Sparam';
cmd = [hspice_path,' -i ',sp_file,' -o ',file_name];
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
end

