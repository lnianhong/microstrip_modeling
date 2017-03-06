function [ Z] = RLGC_2_Z(RLGC,freq)
% convert the RLGC to Z
Z = sqrt((RLGC(:,1)+1i*2*pi*freq.*RLGC(:,2))./(RLGC(:,3)+1i*2*pi*freq.*RLGC(:,4)));

end

