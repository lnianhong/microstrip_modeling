clc;clear;close all;
% filename = 'IBM_singlecpw.txt';
filename = 'list.sp';
fileID = fopen(filename);
data = textscan(fileID,'%s %s %s %s');
fclose(fileID);
G_data = struct();
G_data.dev = data{1}{1};
G_data.lnode = data{2}{1};
G_data.rnode = data{3}{1};
for m = 2:length(data{1})
    tmp_dev = data{1}{m};
    tmp_lnode = data{2}{m};
    tmp_rnode = data{3}{m};
    len_G_data = length(G_data);
    for n = 1:len_G_data
        if issameedge( tmp_lnode,tmp_rnode,G_data(n).lnode,G_data(n).rnode )
            G_data(n).dev = [G_data(n).dev,tmp_dev];
            break;
        end
        if n==len_G_data
            G_data(len_G_data+1).dev = tmp_dev;
            G_data(len_G_data+1).lnode = tmp_lnode;
            G_data(len_G_data+1).rnode = tmp_rnode;
        end
    end
end
G = graph({G_data.lnode},{G_data.rnode});

% h=plot(G,'Layout','layered');
h=plot(G,'Layout','force','Iterations',500);
labeledge(h,{G_data.lnode},{G_data.rnode},{G_data.dev})
