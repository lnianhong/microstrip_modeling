function [ s_params,freq] = read_measure_data(txt_file)
% import the date from txt fils 
% the form of csv file should be like this:
% Freq [GHz] re(St(P1,P1)) im(St(P1,P1)) re(St(P1,P2)) im(St(P1,P2)) re(St(P2,P1)) [im(St(P2,P1)) re(St(P2,P2)) im(St(P2,P2))
% Output:
% Freq: a Nx1 vectorr
% s_params:2x2xN matrix

data_f_s = dlmread(txt_file,'',3,3);
freq = data_f_s(:,1);

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

