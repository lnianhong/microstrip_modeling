function  generate_netlist( file_ID,a,b,p,n)
%a,b,p are Character vectors
% n is int
if n==1
    % G0 C0
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','RG010',a	,p	,'''RG0''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','C010 ',a	,p	,'''C0''' );
    %G1-G3 C1-C3
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','RG011',a	,'np011','''RG1''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','C011 ','np011',p,'''C1''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','RG012',a,'np012','''RG2''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','C012 ','np012',p,'''C2''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','RG013',a,'np013','''RG3''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','C013 ','np013',p,'''C3''' );
    %R0 L0
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','R010 ',a,'ns011','''RO''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','R010 ','ns011','ns012','''LO''' );
    %R1-R3 L1-L3
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','R011 ','ns012','ns013','''R1''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','L011 ','ns012','ns013','''L1''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','R012 ','ns013','ns014','''R2''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','L012 ','ns013','ns014','''L2''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','R013 ','ns014',b,'''R3''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','L013 ','ns014',b,'''L3''' );
    
    % G0 C0
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','RG020',b	,p	,'''RG0''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','C020 ',b	,p	,'''C0''' );
    %G1-G3 C1-C3
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','RG021',b	,'np021','''RG1''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','C021 ','np021',p,'''C1''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','RG022',b,'np022','''RG2''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','C022 ','np022',p,'''C2''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','RG023',b,'np023','''RG3''' );
    fprintf(file_ID,'%-10s \t\t%-10s \t\t%-10s \t\t%-10s\n','C023 ','np023',p,'''C3''' );
    
end

end

