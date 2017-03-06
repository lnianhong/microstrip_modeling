function [ R_sim,Rf_sim ] = Rt_2_R_Rf( one_div_len,R_sim_total,num_freq_point)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
R_sim = zeros(num_freq_point,1);
Rf_sim = R_sim;
for k =1:num_freq_point
    % ft = fit(len_1',R_sim_total(1,:)','poly1')
    ft_test = fittype('4*Rf*x+R');
    ft=fit(one_div_len',R_sim_total(k,:)',ft_test,'Start',[100,1]);
    R_sim(k) = ft.R;
    Rf_sim(k) = ft.Rf;
end

end

