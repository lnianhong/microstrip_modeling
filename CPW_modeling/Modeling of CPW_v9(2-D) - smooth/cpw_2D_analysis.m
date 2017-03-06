% 考虑端口效应，宽度分析
clc;clear;close all
dbstop if error;
len = [150,200,250,300,350];%W ==5
Width_array = [4 5 6 7 8 9 10];
Space_array = [2 3 4 5 6 7 8 9 10];
len_pi = 12.5*1e-6;
cpw_cell = cell(length(Space_array),length(Width_array));
RLGC_0123_mat = zeros(length(Space_array),length(Width_array),16);
for s= 1:length(Space_array)
    space = Space_array(s);
    for w = 1:length(Width_array)
        width = Width_array(w);
        files_info  = new_files_info();
        for k = 1:length(len)
            files_info(k).name=sprintf('./S_parameters_sim/all/L%dW%dS%d.csv',len(k),width,space);
            files_info(k).length = len(k)*1e-6;
            files_info(k).width = width*1e-6;
            files_info(k).space = space*1e-6;
            files_info(k).len_pi =len_pi ;
            files_info(k).num_pi = ceil(files_info(k).length/files_info(k).len_pi-1e-6);
        end
        [ files_info,RLGC_sim,RLGC_f_sim] = reg_RLGC( files_info);
        freq = files_info(1).freq;
        [ RLGC_fit,RLGC_0123,f_fit ] = RLGC_2_0123( RLGC_sim,freq);
        %      plot_RLGC_double(freq,RLGC_sim,RLGC_fit,{'sim','fit'},'RLGC: sim vs fit',{'-r','--b'});
        %% basic info of model
        cpwmodel = new_cpwmodel();
        cpwmodel.files_info = files_info;
        cpwmodel.len = len*1e-6;
        cpwmodel.width = width*1e-6;
        cpwmodel.space = space*1e-6;
        cpwmodel.RLGC_sim = RLGC_sim;
        cpwmodel.RLGC_f_sim = RLGC_f_sim;
        cpwmodel.RLGC_fit = RLGC_fit;
        cpwmodel.RLGC_0123 = RLGC_0123;
        cpwmodel.f_fit = f_fit;
        cpwmodel.gamma_sim = RLGC_2_gamma( RLGC_sim,freq);
        cpwmodel.gamma_fit = RLGC_2_gamma( RLGC_fit,freq);
        cpwmodel = cpwmodel_err(cpwmodel);% error of unit length
        cpwmodel = files_model(cpwmodel);
        cpwmodel = files_err(cpwmodel);
        cpw_cell{s,w} = cpwmodel;
        RLGC_0123_mat(s,w,:) = reshape(RLGC_0123,16,[]);
        clear cpwmodel;
        fprintf('  Finished:S=%d W=%d......\n',space,width);
    end
end


% index : 1:4 R0-R3 5-8:L0:L3 
mesh_RLGC_2D_single( Width_array,Space_array,RLGC_0123_mat,1)


plot_RLGC_2Dvar( RLGC_0123_mat,Width_array,Space_array,'width',5)

%
recycle('on')
save_name = 'tmp_data/cpw_2D_W4-10_S2_10.mat';
if exist(save_name,'file')
    delete(save_name);
end
save(save_name,'cpw_cell','RLGC_0123_mat','Width_array','Space_array');


