clc;clear;close all ;
dbstop if error;
data = load('tmp_data/cpwmodelw4-12.mat');
cpwmodel_all =data.cpwmodel; clear data;
cpwmodel_test =cpwmodel_all(1); 
RLGC_len = RLGC0123_2_RLGC( cpwmodel_test.files_info(1).freq,cpwmodel_test.RLGC_0123) ;
RLGC = cpwmodel_test.RLGC_fit;
plot_RLGC_double(cpwmodel_test.files_info(1).freq,RLGC_len,RLGC,{'creat','origin'},{'test RLGC0123_2RLGC'});