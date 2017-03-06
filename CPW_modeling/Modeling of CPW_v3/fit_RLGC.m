function [Real_fit,Imag_fit,Real_0123_fit,Imag_0123_fit,f_fit,Err,Err_min] = ...,
          fit_RLGC(f_123_mat,freq,R,L,G,C,lambda,weight,flag,num_RL_net)
% INPUT:
% f_123_mat:each column is a sample,the size of f_123 should be 3xN
% freq: freq should be a vector
% lambda: a 2x1 vector
% weight :a Nx2 matrix

narginchk(9,10);%
% Check the reference impedance
if nargin < 10
    num_RL_net = 3;
end
if (num_RL_net ~= 3)
    error( 'Only 3 R-L NETWORKS in one section is supported!   ');
end
if sum(lambda)~=1
    error('The sum of lambda should be 1');
end
if length(lambda)~=2
    error('The length of lambda should be 2');
end
if ~sum(weight,2)
    error('The sum of weight should be 1');
end
if size(weight,1)~=length(freq) || size(weight,2)~=2
    error('weight should be a matrix of N-by-2');
end

Num_f123 = size(f_123_mat,2);
lambda_Real = lambda(1);
lambda_Imag = lambda(2);

weight_Real = weight(:,1)';
weight_Imag = weight(:,2)';

Err_Real = ones(Num_f123,1);
Err_Imag = ones(Num_f123,1);
Err = ones(Num_f123,1);
Err_min = 1;


%% model RL
for ii = 1:Num_f123
    f_123 = f_123_mat(:,ii);
    [R_0123,L_0123,G_0123,C_0123] = cpw_param_extract( f_123,freq,R,L,G,C,flag,num_RL_net);
    % L_0123,R_0123,G_123,C_0123 are the prameters of each section!
    if strcmp(flag,'RL')
        Real_0123 = R_0123;
        Imag_0123 = L_0123;
        Real =R;
        Imag = L;
    elseif strcmp(flag,'GC')
        Real_0123 = G_0123;
        Imag_0123 = C_0123;
        Real =G;
        Imag = C;
    else
        error('flag should be RL or GC')
    end
    
    if sum(Imag_0123 <0) || sum(Real_0123<0)
        continue
    end
    
    
    Real_model = Real_0123(1) + Real_0123(2)* (1-1./(1+(freq./f_123(1)).^2)) + ...,
                                Real_0123(3)* (1-1./(1+(freq./f_123(2)).^2)) + ...,
                                Real_0123(4)* (1-1./(1+(freq./f_123(3)).^2));
    
    Imag_model = Imag_0123(1) + Imag_0123(2)* (1./(1+(freq./f_123(1)).^2)) + ...,
                                Imag_0123(3)* (1./(1+(freq./f_123(2)).^2)) + ...,
                                Imag_0123(4)* (1./(1+(freq./f_123(3)).^2));
    
    Err_Real(ii) = weight_Real*eval_model(Real,Real_model,'abs');% average error of R
    Err_Imag(ii) = weight_Imag*eval_model(Imag,Imag_model,'abs');% average error of L
    Err(ii) = lambda_Real*Err_Real(ii) + lambda_Imag*Err_Imag(ii);
    
    if Err(ii) < Err_min
        Err_min = Err(ii);
        Real_fit = Real_model;
        Imag_fit = Imag_model;
        Imag_0123_fit = Imag_0123;
        Real_0123_fit = Real_0123;
        f_fit = f_123;
    end
    
end
end



