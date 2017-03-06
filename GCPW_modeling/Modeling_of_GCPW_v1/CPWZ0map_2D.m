clc;clear;close all;
%% load data
data_name = 'tmp_data/cpw_2D_W4-10_S3_10_scalable.mat';
load(data_name);
f = 100;
index = round(2*f);
[m,n] = size(cpw_cell);
Z0map = cell(m,n);
for ii=1:m
    for jj=1:n
       Z0map{ii,jj} = num2str(cpw_cell{ii,jj}.Z_sim(f));
    end
end
Space_str = cell(m,1);
for ii=1:m
    str = sprintf('Space=%d',Space_array(ii));
    Space_str(ii,1) ={str};
end
Width_str = cell(1,n+1);
for ii=1:n
    str = sprintf('Width=%d',Width_array(ii));
    Width_str(ii+1) ={str};
end
file_name = ['Z0map_',num2str(f),'GHz.xlsx'];
xlswrite(file_name,[Width_str;Space_str Z0map]);
