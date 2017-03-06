function generate_param_2D(file_ID,coef_2D,num_sub)

fprintf(file_ID,'.param\n');
fprintf(file_ID,'*\n');
fprintf(file_ID,'+ l = ''(len*scale)''\n');
fprintf(file_ID,'+ w = ''(width*scale)*1e6''\n');
fprintf(file_ID,'+ s = ''(space*scale)*1e6''\n');
fprintf(file_ID,'*\n');
fprintf(file_ID,'*\n');
RLGC_str = {'R','L','G','C'};
formatSpec1 = ['+ %s%1d_unit = ''((%.15e)*(s**3)+(%.15e)*(s**2)+(%.15e)*s+(%.15e))*(w**3)'...
                           '+((%.15e)*(s**3)+(%.15e)*(s**2)+(%.15e)*s+(%.15e))*(w**2)'...
                           '+((%.15e)*(s**3)+(%.15e)*(s**2)+(%.15e)*s+(%.15e))*w'...
                           '+((%.15e)*(s**3)+(%.15e)*(s**2)+(%.15e)*s+(%.15e))''\n'];
for m =1:4
    for n = 1:4
        str = sprintf(formatSpec1,RLGC_str{m},n-1,reshape(coef_2D(:,:,4*m-4+n),1,[]));
        str = replace(str,'e+00','');
        str = replace(str,'e-00','');
        str = replace(str,'e+0','e');
        str = replace(str,'e-0','e-');
        fprintf(file_ID,str);
    end
end
fprintf(file_ID,'*\n');
formatSpec2 = '+ %s%1d  = ''l*%s%1d_unit/%d''\n';
formatSpec3 = '+ R%s%1d = ''%d/(l*%s%1d_unit)''\n';
for m =1:4
    for n = 1:4
        if m == 3
            str = sprintf(formatSpec3,RLGC_str{m},n-1,num_sub,RLGC_str{m},n-1);
        else
            str = sprintf(formatSpec2,RLGC_str{m},n-1,RLGC_str{m},n-1,num_sub);
        end
        fprintf(file_ID,str);
    end
end
fprintf(file_ID,'*\n');
end

