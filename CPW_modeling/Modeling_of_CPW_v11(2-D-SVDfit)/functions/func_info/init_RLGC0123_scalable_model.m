function [ RLGC_0123_scalable_model ] = init_RLGC0123_scalable_model( cpwmodel_w )
%not used
%   Detailed explanation goes here

RLGC_0123_scalable_model = new_RLGC0123_scalable_model();
RLGC_0123_scalable_model.field = {};%width or space
RLGC_0123_scalable_model.field_data = {};
RLGC_0123_scalable_model.R_0123 ={};
RLGC_0123_scalable_model.L_0123 ={};
RLGC_0123_scalable_model.G_0123 ={};
RLGC_0123_scalable_model.C_0123 ={};

RLGC_0123_scalable_model.field_data_interp = {};
RLGC_0123_scalable_model.R_0123_interp ={};
RLGC_0123_scalable_model.L_0123_interp ={};
RLGC_0123_scalable_model.G_0123_interp ={};
RLGC_0123_scalable_model.C_0123_interp ={};

RLGC_0123_scalable_model.fitfunc_type = {};
RLGC_0123_scalable_model.R0123_cfit = {};
RLGC_0123_scalable_model.L0123_cfit = {};
RLGC_0123_scalable_model.G0123_cfit = {};
RLGC_0123_scalable_model.C0123_cfit = {};
end

