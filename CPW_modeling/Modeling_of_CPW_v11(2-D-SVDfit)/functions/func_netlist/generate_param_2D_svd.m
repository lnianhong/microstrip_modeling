function generate_param_2D_svd(file_ID,coef_2D,num_sub,order)
order_str = [num2str(order(1)),num2str(order(2))];
fprintf(file_ID,'.param\n');
fprintf(file_ID,'*\n');
fprintf(file_ID,'+ l = ''(len*scale)''\n');
fprintf(file_ID,'+ w = ''(width*scale)*1e6''\n');
fprintf(file_ID,'+ s = ''(space*scale)*1e6''\n');
fprintf(file_ID,'*\n');
fprintf(file_ID,'*\n');
RLGC_str = {'R','L','G','C'};
formatSpec33 = ['+ %s%1d_unit = ''((%.15e)+(%.15e)*w+(%.15e)*s+(%.15e)*(w**2)+(%.15e)*w*s'...
                                  '+(%.15e)*(s**2)+(%.15e)*(w**3)+(%.15e)*(w**2)*s'...
                                  '+(%.15e)*w*(s**2)+(%.15e)*(s**3))''\n'];
formatSpec44 = ['+ %s%1d_unit = ''((%.15e)+(%.15e)*w+(%.15e)*s+(%.15e)*(w**2)+(%.15e)*w*s'...
                                   '+(%.15e)*(s**2)+(%.15e)*(w**3)+(%.15e)*(w**2)*s'...
                                   '+(%.15e)*w*(s**2)+(%.15e)*(s**3)+(%.15e)*(w**4)'...
                                   '+(%.15e)*(w**3)*s+(%.15e)*(w**2)*(s**2)+(%.15e)*w*(s**3)'...
                                   '+(%.15e)*(s**4))''\n'];
formatSpec55 = ['+ %s%1d_unit = ''((%.15e)+(%.15e)*w+(%.15e)*s+(%.15e)*(w**2)+(%.15e)*w*s'...
                                   '+(%.15e)*(s**2)+(%.15e)*(w**3)+(%.15e)*(w**2)*s'...
                                   '+(%.15e)*w*(s**2)+(%.15e)*(s**3)+(%.15e)*(w**4)'...
                                   '+(%.15e)*(w**3)*s +(%.15e)*(w**2)*(s**2)'...
                                   '+(%.15e)*w*(s**3)+(%.15e)*(s**4)+(%.15e)*(w**5)'...
                                   '+(%.15e)*(w**4)*s +(%.15e)*(w**3)*(s**2)'...
                                   '+(%.15e)*(w**2)*(s**3)+(%.15e)*w*(s**4)+(%.15e)*(s**5))''\n'];
switch order_str
    case '33'
        formatSpec_unit = formatSpec33 ;
    case '44'
        formatSpec_unit = formatSpec44;
    case '55'
        formatSpec_unit = formatSpec55;
    otherwise
        error('Error: the order should be one of [''33'' ''44'' ''55'' ')     
end
% formatSpec_unit = ['+ %s%1d_unit = ''((%.15e)*(s**3)+(%.15e)*(s**2)+(%.15e)*s+(%.15e))*(w**3)'...
%                            '+((%.15e)*(s**3)+(%.15e)*(s**2)+(%.15e)*s+(%.15e))*(w**2)'...
%                            '+((%.15e)*(s**3)+(%.15e)*(s**2)+(%.15e)*s+(%.15e))*w'...
%                            '+((%.15e)*(s**3)+(%.15e)*(s**2)+(%.15e)*s+(%.15e))''\n'];
for m =1:4
    for n = 1:4
        str = sprintf(formatSpec_unit,RLGC_str{m},n-1,reshape(coef_2D(:,4*m-4+n),1,[]));
        str = replace(str,'e+00','');
        str = replace(str,'e-00','');
        str = replace(str,'e+0','e');
        str = replace(str,'e-0','e-');
        fprintf(file_ID,str);
    end
end
fprintf(file_ID,'*\n');
formatSpec_RLC = '+ %s%1d  = ''l*%s%1d_unit/%d''\n';
formatSpec_G = '+ R%s%1d = ''%d/(l*%s%1d_unit)''\n';
for m =1:4
    for n = 1:4
        if m == 3
            str = sprintf(formatSpec_G,RLGC_str{m},n-1,num_sub,RLGC_str{m},n-1);
        else
            str = sprintf(formatSpec_RLC,RLGC_str{m},n-1,RLGC_str{m},n-1,num_sub);
        end
        fprintf(file_ID,str);
    end
end
fprintf(file_ID,'*\n');
end
%      Linear model Poly33:
%      sf(x,y) = p00+p10*x+p01*y+p20*x^2+p11*x*y+p02*y^2+p30*x^3+
%                     p21*x^2*y+p12*x*y^2+p03*y^3
%      sf(x,y) = p00+p10*x+p01*y+p20*x^2+p11*x*y+p02*y^2+p30*x^3+
%                     p21*x^2*y+p12*x*y^2+p03*y^3+p40*x^4+p31*x^3*y 
%                    +p22*x^2*y^2+p13*x*y^3+p04*y^4
%      sf(x,y) = p00+p10*x+p01*y+p20*x^2+p11*x*y+p02*y^2+p30*x^3+
%                     p21*x^2*y+p12*x*y^2+p03*y^3+p40*x^4+p31*x^3*y 
%                    +p22*x^2*y^2+p13*x*y^3+p04*y^4+p50*x^5+p41*x^4*y 
%                    +p32*x^3*y^2+p23*x^2*y^3+p14*x*y^4+p05*y^5
