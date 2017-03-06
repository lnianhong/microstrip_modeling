function startup()
% startup()
% --------------------------------------------------------
% Faster R-CNN
% Copyright (c) 2015, Shaoqing Ren
% Licensed under The MIT License [see LICENSE for details]
% --------------------------------------------------------

curdir = fileparts(mfilename('fullpath'));
%returns a path string, p, that includes all the folders and subfolders below matlabroot/toolbox, including empty subfolders
addpath(genpath(fullfile(curdir, 'functions')));

fprintf('Modeling of GCPW startup done\n');
end