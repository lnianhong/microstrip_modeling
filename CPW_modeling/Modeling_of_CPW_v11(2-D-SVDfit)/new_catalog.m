clc;
clear;
parentfolder = 'S_parameters_sim';
foldername = 'Space_Width_Length';
mkdir(parentfolder,foldername)
foler_p1 = 'S_parameters_sim/Space_Width_Length';
for S=2:10
    mkdir(foler_p1,['S',num2str(S),'WL']);
    foler_p2 = [foler_p1,'/','S',num2str(S),'WL'];
    for W =4:10
        mkdir(foler_p2,['S',num2str(S),'W',num2str(W),'L']);
    end
end
