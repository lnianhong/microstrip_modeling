clc;clear;close all;
%% load data
data_name = 'tmp_data/cpw_2D_W4-10_S3_10_scalable.mat';
load(data_name);
width = 0:0.1:14;
space = 0:0.1:14;
m = length(width); 
n = length(space);

result = zeros(m*n,3);
tic;
for ii = 1:m
    for jj = 1:n
        op= eval_2Dscalable_svd( width(ii),space(jj),coeffs,[3 3]);
        result((ii-1)*n+jj,:) =[width(ii),space(jj), sum(op<=0)];
    end
end
index = result(:,3)==0;
t = toc;
figure
hold on 
plot(result(index,1),result(index,2),'g*');
% plot(result(~index,1),result(~index,2),'bo');
legend('postive','negative')
plot(4:10,3*ones(1,length(4:10)),'r-')
plot(4:10,10*ones(1,length(4:10)),'r-')
plot(4*ones(1,length(3:10)),3:10,'r-')
plot(10*ones(1,length(3:10)),3:10,'r-')
ylabel('Space');
xlabel('Width');
hold off