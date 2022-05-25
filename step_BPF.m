function fiteredStep = step_BPF(dt,Tf)                        
L = Tf/dt+1;             % Length of signal
stepF=[zeros(1,floor(L/6)),0.001*ones(1,ceil(5*L/6))];
Xi=0.8;
Wn=2*pi*50;
BPF=tf([Wn^2 0],[1 2*Xi*Wn Wn^2]);
disFilter=c2d(BPF,dt,'tustin');
 [num,den] = tfdata(disFilter);
 Dnum=cell2mat(num);
 Dden=cell2mat(den);
 fiteredStep=zeros(1,L);
 for k =[4:L]
    fiteredStep(k)=Dnum*stepF(k-[0:2])'-Dden(2:3)*fiteredStep(k-[1:2])';
 end
% figure(1)
% plot(t,fiteredStep)

end