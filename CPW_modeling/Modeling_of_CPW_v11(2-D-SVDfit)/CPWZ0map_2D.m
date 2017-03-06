clc;clear;close all;
%% load data
data_name = 'tmp_data/cpw_2D_W4-10_S3_10_scalable.mat';
load(data_name);
f = 76;
index = round(2*f);
[m,n] = size(cpw_cell);
Z0map_sim = cell(m,n);
Z0map_scalable = cell(m,n);
for ii=1:m
    for jj=1:n
       % z smi
       Z_real = sprintf('%.2f',real(cpw_cell{ii,jj}.Z_sim(f)));
       Z_imag = sprintf('%.2fj',imag(cpw_cell{ii,jj}.Z_sim(f)));
       Z0map_sim{ii,jj} = [Z_real,Z_imag];
       % Z scalable
       Z_real = sprintf('%.2f',real(cpw_scalable_2D{ii,jj}.Z_fit(f)));
       Z_imag = sprintf('%.2fj',imag(cpw_scalable_2D{ii,jj}.Z_fit(f)));
       Z0map_scalable{ii,jj} = [Z_real,Z_imag];
%        Z0map{ii,jj} = num2str(cpw_cell{ii,jj}.Z_sim(f));
    end
end
Space_str = cell(m,1);
for ii=1:m
    str = sprintf('Space=%dum',Space_array(ii));
    Space_str(ii,1) ={str};
end
Width_str = cell(1,n+1);
Width_str(1) = {['Freq=',num2str(f),'GHz']};
for ii=1:n
    str = sprintf('Width=%dum',Width_array(ii));
    Width_str(ii+1) ={str};
end
file_name = ['Z0map_',num2str(f),'GHz.xlsx'];
Width_str(1) = {['Freq=',num2str(f),'GHz sim']};
xlswrite(file_name,[Width_str;Space_str Z0map_sim],1);
Width_str(1) = {['Freq=',num2str(f),'GHz scalable']};
xlswrite(file_name,[Width_str;Space_str Z0map_scalable],2);