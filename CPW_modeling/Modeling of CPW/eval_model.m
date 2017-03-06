function [ Err ] = eval_model(sim_data,model_data,mode)
% evaluation the model
% Output Err is a vector
narginchk(2,3);%
% Check the reference impedance
if nargin < 3
   mode = 'square';
end
switch mode
    case 'square'
        Err = ((1-model_data./sim_data).^2);
    case 'abs'
        Err = abs((1-model_data./sim_data));
    otherwise
        error('invald mode!')
end


end

