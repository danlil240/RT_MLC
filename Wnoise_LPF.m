function fiteredWnoise = Wnoise_LPF(dt,Tf)    
L = ceil(Tf/dt+1);             % Length of signal
Wnoise =0.005*randn(1,L);
Wn = 2*pi*100;
Xi = 0.7;
LPF = tf(0.2*Wn^2,[1 2*Xi*Wn Wn^2]);
disFilter=c2d(LPF,dt,'tustin');
 [num,den] = tfdata(disFilter);
 Dnum=cell2mat(num);
 Dden=cell2mat(den);
 fiteredWnoise=zeros(1,L);
 for k =[3:L]
    fiteredWnoise(k)=Dnum*Wnoise(k-[0:2])'-Dden(2:end)*fiteredWnoise(k-[1:2])';
 end
% fiteredWnoise2=bandpass(Wnoise,[2 100],1000);
% figure(1)
% plot(t,fiteredWnoise)
% title('Signal Corrupted with Zero-Mean Random Noise')
% xlabel('t (milliseconds)')
% ylabel('X(t)')
% Y = fft(fiteredWnoise);
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:(L/2))/L;
% figure(2)
% plot(f,P1) 
% 
% [y,tOut,x]=lsim(LPF,Wnoise,t);
% w=bandpass(X,[49 121],1000);
% plot(t,w)
% Y = fft(y);
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:(L/2))/L;
% figure(3)
% plot(f,P1) 
%%

% 
%  syms z
%  G_sym = vpa(poly2sym(cell2mat(num),z)/poly2sym(cell2mat(den),z),12)
% figure(5)
% bode (LPF,HPF,BPF); legend('LPF','HPH','BPF')
% figure(6)
end