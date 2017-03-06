function  generate_netlist( file_ID,a,b,p,n)
%a,b,p are Character vectors
% n is int
fprintf(file_ID,'*******************************************************\n');
fprintf(file_ID,'******                  Netlist                  ******\n');
fprintf(file_ID,'*******************************************************\n');

formatSpec = '%-10s \t\t%-10s \t\t%-10s \t\t''%s''\n';
node_r = a;
gnd = p;

for m=1:n+1
    node_l = node_r;
    if m==1 || m==(n+1)
        mult_RG = '2*';
        mult_C = '0.5*';
    else        
        mult_RG = '';
        mult_C = '';
    end
    %% parallel part
    %G0
    instance_name = sprintf('RG%02d%1d',m,0);
    fprintf(file_ID,formatSpec,instance_name,node_l,gnd,[mult_RG,'RG0']);
    %C0
    instance_name = sprintf('C%02d%1d',m,0);
    fprintf(file_ID,formatSpec,instance_name,node_l,gnd,[mult_C,'C0']);
    %G123 C123
    for ii=1:3
        node_m = sprintf('np%02d%1d',m,ii);
        instance_name = sprintf('RG%02d%1d',m,ii);
        fprintf(file_ID,formatSpec,instance_name,node_l,node_m,[mult_RG,'RG',num2str(ii)] );
        instance_name = sprintf('C%02d%1d',m,ii);
        fprintf(file_ID,formatSpec,instance_name,node_m,gnd,[mult_C,'C',num2str(ii)] );
    end
    %% serial part
    if m<=n
        %R0
        node_l = node_r;
        instance_name = sprintf('R%02d%1d',m,0);
        node_r = sprintf('ns%02d%1d',m,1);
        fprintf(file_ID,formatSpec,instance_name,node_l,node_r,'R0');
        %L0;
        instance_name = sprintf('L%02d%1d',m,0);
        node_l = node_r;
        node_r = sprintf('ns%02d%1d',m,2);
        fprintf(file_ID,formatSpec,instance_name,node_l,node_r,'L0');
        %R123 L123
        for ii=1:3
            node_l = node_r;
            if m==n && ii==3
                node_r = b;
            else
                node_r = sprintf('ns%02d%1d',m,ii+2);
            end
            instance_name = sprintf('R%02d%1d',m,ii);
            fprintf(file_ID,formatSpec,instance_name,node_l,node_r,['R',num2str(ii)] );
            instance_name = sprintf('L%02d%1d',m,ii);
            fprintf(file_ID,formatSpec,instance_name,node_l,node_r,['L',num2str(ii)] );
        end
    end
    
end

end

