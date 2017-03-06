function [ RLGC_len ] = RLGC0123_2_RLGC( freq,RLGC_0123 )
% convert the RLGC0123 to unit length RLGC
R_0123_len = RLGC_0123(:,1);
L_0123_len = RLGC_0123(:,2);
G_0123_len = RLGC_0123(:,3);
C_0123_len = RLGC_0123(:,4);
% f_RL = f_fit(:,1);
% f_GC = f_fit(:,2);
f_RL = (R_0123_len(2:4)./L_0123_len(2:4))./(2*pi);
f_GC = (G_0123_len(2:4)./C_0123_len(2:4))./(2*pi);

R_len = R_0123_len(1) + R_0123_len(2)* (1-1./(1+(freq./f_RL(1)).^2)) + ...,
    R_0123_len(3)* (1-1./(1+(freq./f_RL(2)).^2)) + ...,
    R_0123_len(4)* (1-1./(1+(freq./f_RL(3)).^2));

L_len = L_0123_len(1) + L_0123_len(2)* (1./(1+(freq./f_RL(1)).^2)) + ...,
    L_0123_len(3)* (1./(1+(freq./f_RL(2)).^2)) + ...,
    L_0123_len(4)* (1./(1+(freq./f_RL(3)).^2));

G_len =G_0123_len(1) +G_0123_len(2)* (1-1./(1+(freq./f_GC(1)).^2)) + ...,
    G_0123_len(3)* (1-1./(1+(freq./f_GC(2)).^2)) + ...,
    G_0123_len(4)* (1-1./(1+(freq./f_GC(3)).^2));

C_len = C_0123_len(1) + C_0123_len(2)* (1./(1+(freq./f_GC(1)).^2)) + ...,
    C_0123_len(3)* (1./(1+(freq./f_GC(2)).^2)) + ...,
    C_0123_len(4)* (1./(1+(freq./f_GC(3)).^2));

RLGC_len = [R_len,L_len,G_len,C_len];

end

