function [ s_params,freq] = hfss_csv_2_sparams(csv_file,zero_freq,freq_unit)
% import the date from cvs fils 
% the form of csv file should be like this:
% Freq [GHz] re(St(P1,P1)) im(St(P1,P1)) re(St(P1,P2)) im(St(P1,P2)) re(St(P2,P1)) [im(St(P2,P1)) re(St(P2,P2)) im(St(P2,P2))
% Output:
% Freq: a Nx1 vectorr
% s_params:2x2xN matrix
narginchk(2,3);%
% Check the reference impedance
if nargin < 3
    freq_unit = 'GHz';
end

switch freq_unit
    case 'THz'
        mult_param = 1e12;
    case 'GHz'
        mult_param = 1e9;
    case 'MHz'
        mult_param = 1e6;
    case 'KHz'
        mult_param = 1e3;
     case 'Hz'
        mult_param = 1;
    otherwise
        error('invalid freq unit!!!')
end
if zero_freq ==1
    data_f_s = csvread(csv_file,1,0);
else
    data_f_s = csvread(csv_file,2,0);
end

freq = data_f_s(:,1)*mult_param;

s_11 = complex(data_f_s(:,2),data_f_s(:,3));
s_12 = complex(data_f_s(:,4),data_f_s(:,5));
s_21 = complex(data_f_s(:,6),data_f_s(:,7));
s_22 = complex(data_f_s(:,8),data_f_s(:,9));
s_params = complex(zeros(2,2,length(freq)));
s_params(1,1,:) = (s_11+s_22)./2;
s_params(1,2,:) = (s_12+s_21)./2;
s_params(2,1,:) = s_params(1,2,:);
s_params(2,2,:) = s_params(1,1,:);



end

