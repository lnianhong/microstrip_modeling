function [files, RLGC_sim,RLGC_f_sim] = reg_RLGC( files,freq_min,freq_max,num_freq_point,mode)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if nargin < 2
    freq_min = 0.5e9;
end
if nargin < 3
    freq_max = 100e9;
end
if nargin < 4
    num_freq_point = 200;
end
if nargin < 5
    mode = {'reg(RL)+mu(GC)','add'};
end

files_num = length(files);
len = zeros(1,files_num);

 
R_sim_total = zeros(num_freq_point,files_num);
L_sim_total = zeros(num_freq_point,files_num);
G_sim_total = zeros(num_freq_point,files_num);
C_sim_total = zeros(num_freq_point,files_num);


for k = 1:files_num
    file_name =files(k).name;
    len(k) = files(k).length;
    zero_freq = 0;
    [ s_params,freq] = hfss_csv_2_sparams(file_name,zero_freq,'GHz');
    if max(freq)< freq_max || min(freq)>freq_min
        error('max(freq)< freq_max || min(freq)>freq_min');
    end
    s_params = s_params(:,:,freq<=freq_max & freq>=freq_min );
    files(k).Sparam_total =s_params; 
    files(k).freq = freq(freq<=freq_max & freq>=freq_min );
    [files(k).RLGC_total,files(k).gamma_total,files(k).Z_total] = ...,
        S_2_RLGC(s_params,files(k).freq,len(k)); % the unit length is meter!
    files(k).Sparam_sim_total = s_params;
end

RLGC_sim_total = [files.RLGC_total];
R_sim_total = RLGC_sim_total(:,1:4:end);
L_sim_total = RLGC_sim_total(:,2:4:end);
G_sim_total = RLGC_sim_total(:,3:4:end);
C_sim_total = RLGC_sim_total(:,4:4:end);

one_div_len = 1./len;

[ R_sim,Rf_sim ] = Rt_2_R_Rf( one_div_len,R_sim_total,num_freq_point);
[ L_sim,Lf_sim ] = Rt_2_R_Rf( one_div_len,L_sim_total,num_freq_point);
if strcmp(mode{1},'reg(RLGC)')
    [ G_sim,Gf_sim ] = Rt_2_R_Rf( one_div_len,G_sim_total,num_freq_point);
    [ C_sim,Cf_sim ] = Rt_2_R_Rf( one_div_len,C_sim_total,num_freq_point);
end
if strcmp(mode{1},'reg(RL)+mu(GC)')
    C_sim = mean(C_sim_total,2);
    Cf_sim = zeros(size(C_sim));
    G_sim = mean(G_sim_total,2);
    Gf_sim = zeros(size(G_sim));

end
   
RLGC_sim = [R_sim,L_sim,G_sim,C_sim];
RLGC_f_sim = [Rf_sim,Lf_sim,Gf_sim,Cf_sim];


end

