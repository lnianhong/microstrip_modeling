clc;clear;
load('CL2W4S4')

%********S****************%
S11=complex(reStP1P1,imStP1P1);
S12=complex(reStP1P2,imStP1P2);
S21=complex(reStP2P1,imStP2P1);
S22=complex(reStP2P2,imStP2P2);


S1122=(S11+S22)/2;
S1221=(S12+S21)/2;
% %********ABCD****************%
z0=50;
%   load('r');

for i=1:size(FreqGHz)
   
   w(i,:)=2*pi*FreqGHz(i)*1e9;
   f(i,:)=(FreqGHz(i)*1e9)^2;
   f1(i,:)=w(i)^2;
   F(i,:)=FreqGHz(i);
   
   S = [S1122(i) S1221(i); S1221(i) S1122(i)];
%     abcd(:,:,i)=s2abcd(S,z0);
%    a(i,:)=(abcd(1,1,i)+abcd(2,2,i))/2;
  
%    r(i,:)=log( 1/( (1-S11(i)^2+S21(i)^2)/(2*S21(i)) + sqrt(((S11(i)^2-S21(i)^2+1)^2-(2*S11(i))^2)/(2*S21(i))^2) ))/(400*1e-6);
   abcd(:,:,i)=s2abcd(S,z0);
   
   a(i,:)=abcd(1,1,i);
   m = acosh(a);
   
   Rr(i,:)=real(m(i,:)/(200*1e-4));
   Ir(i,:)=imag(m(i,:)/(200*1e-4));
   
%     a(i,:)=real(r(i,:));
%     b(i,:)=imag(r(i,:));
   
%    z(i,:)=sqrt((z0^2)*((1+S11(i))^2-(S21(i))^2)/((1-S11(i))^2-(S21(i))^2));
  
%    R(i,:)=real(r(i)*z(i));
%    L(i,:)=imag(r(i)*z(i))/w(i);
 
%   syms R1 R2 L1 L2 
%       
%  [L1,L2,R1,R2]=solve([(2.524e23*R2*L1^2+R2*R1*(R1+R2))/(2.524e23*L1^2+(R1+R2)^2)==R(i,1),...
%                       (R2^2*L1)/(2.524e23*L1^2+(R1+R2)^2)+L2==L(i,1),...
%                        (2.524e23*R2*L1^2+R2*R1*(R1+R2))/(2.524e23*L1^2+(R1+R2)^2)==R(i+1),...
%                       (R2^2*L1)/(2.524e23*L1^2+(R1+R2)^2)+L2==L(i+1)],...
%                       [L1,L2,R1,R2])
% R1 =eval(R1);
% R2 =  eval(R2);
% L1 =  eval(L1);
% L2 =  eval(L2);

   
%    G(i,:)=real(r(i)/z(i));
%    C(i,:)=imag(r(i)/z(i))/w(i);
   
%     WR(i,:)= w(i)^2/R(i);
%     WRL(i,:)=w(i)^2*L(i)/R(i);
%    WG(i,:)= w(i)^2/G(i);
%    WGC(i,:)=w(i)^2*C(i)/G(i);

end    



% x=f(:);
% y=f1(:).*f1(:);
%  +(1.345e4+7.5059e3)^2
% x1= ((1.345e4*8.6211e-8*8.6211e-8*4*pi^2.*y+(1.345e4+7.5059e3)*7.5059e3*1.345e4)/(8.6211e-8*8.6211e-8*4*pi^2*y+(1.345e4+7.5059e3)^2))/1e3;
%  x2= (((1.726e4^2*1.42e-7)/(1.726e4^2*4*pi^2*f.*f)+(1.345e4+7.5059e3)^2)+3.1907e-7);

% y1 = 4*pi^2*x/1.345e4 + (1.345e4+7.5059e3)^2/(1.345e4*8.6211e-8*8.6211e-8);
% y2 = 4*pi^2*x*3.0002e-7/1.345e4 + ((1.345e4+7.5059e3)^2*3.0002e-7 +1.345e4*1.345e4 * 8.6211e-8 )/(1.345e4*8.6211e-8*8.6211e-8);

% figure
% plot(F,a)
%  plot(x,y1)
% plot(x,y2)



% syms x
%  for i=1:size(Freq)
%    
%    eqn = a(i,:)==(exp(x)+exp(-x))/2;      
%    solx(i,:) = solve(eqn,x)

