function [ s_params,freq] = ads_csv_2_sparams( csv_file)
% import the date from ads cvs fils 
% the form of csv file should be like this:
%
% Output:
% Freq: a Nx1 vectorr
% s_params:2x2xN matrix

% fileID = fopen('names.txt','r');
% C = textscan(fileID,'%q %*q %*d %f','Delimiter',',');
% fclose(fileID);

file_cell = textscan(csv_file,'%s ')





end

