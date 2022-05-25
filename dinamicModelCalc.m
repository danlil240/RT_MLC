clc
format long

k=309.2904;%1272.8;% %N/m
c=0.1790%;0.2557; %N*s/m
mass=0.1800;%0.48;% %kg
gap=3E-4; %ms
C_magnetic=3.73e-6;%N*m^2/A^2
Ib=30E-3;%A
% A=[0 1; -5529.8 -0.5327];
% B=[0 17.2685]';
% C=[1 0];
% D=0;

A=[0 1; -k/mass-(4*C_magnetic*Ib^2)/(mass*gap^3) -c/mass];
B=[0 (4*C_magnetic*Ib)/(mass*gap^2)]';
C=[1 0];
D=0;

Ts=0.0005;
sys=ss(A,B,C,D)
%initial(sys,[1e-5;0])
dsis=c2d(sys,0.001)
step(dsis)
[tf1 tf2]=ss2tf(A,B,C,D)
tf1=tf([tf1],[tf2])
dtf1=c2d(tf1,Ts)
% xsi=
% Wn=
Vd=eye(2);
Vn=10;

L=dlqr(dsis.A',dsis.C',Vd,Vn)
Lc=lqr(A',C',Vd,Vn)
Q=diag([22000,0.1]);
R=0.001;
Kr_c=lqr(A,B,Q,R)
Kr=dlqr(dsis.A,dsis.B,Q,R)

