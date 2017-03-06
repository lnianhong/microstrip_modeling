function [ gamma ] = RLGC_2_gamma( RLGC,freq)
% convert the RLGC to gamma
gamma = sqrt((RLGC(:,1)+RLGC(:,2).*1i.*2.*pi.*freq).*(RLGC(:,3)+RLGC(:,4).*1i.*2.*pi.*freq));

end

