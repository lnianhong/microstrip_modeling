function [ coeffs,RLGC_0123_2D_scalable] = fit_RLGC0123_2D_SVD( Width_array,Space_array,RLGC_0123_mat,order)
% get the scalable function of RLGC0123
% the var should be a vector,each column of RLGC0123_var is a samle
% X is width
% Y is space

Xd = size(RLGC_0123_mat,2);
Yd = size(RLGC_0123_mat,1);
[W_mesh,S_mesh] = meshgrid(Width_array,Space_array);
X = reshape(W_mesh,[],1);
Y = reshape(S_mesh,[],1);
coeffs = zeros((order(1)+1)*(order(2)+2)/2,16);
RLGC_0123_2D_scalable = zeros(size(RLGC_0123_mat));
for ii =1:16
    Z = reshape(RLGC_0123_mat(:,:,ii),[],1);
    sf = fit([X, Y],Z,['poly',num2str(order(1)),num2str(order(2))]);
    coeffs(:,ii) = (coeffvalues(sf))';
    Zbar = feval(sf,[X Y]);
    RLGC_0123_2D_scalable(:,:,ii) = reshape(Zbar,Yd,Xd);
    if sum((Zbar<0))
        fprintf('RLGC0123 have negative value(s)!\n')
        fprintf('RLGC:%d\n',ii);
        [row,col] = find(reshape(Zbar,Yd,Xd)<0);
        fprintf('Space:%dum Width:%dum\n ',[row+1,col+3]');
        
%         warning('RLGC0123 have negative value(s)!')
    end
end
if sum(sum(sum((RLGC_0123_2D_scalable<0))))
    error('RLGC0123 have negative value(s)!')
end
% plot(sf,[X,Y],Z)


% for ii=1:16
%     Z = reshape(RLGC_0123_mat(:,:,1),[],1);
%     coeffs = fit2dPolySVD( X, Y,Z , 5);
%     Zbar = eval2dPoly( X, Y, coefs );
% end


end

