function J=MLC_evaluator_LQR_daniel(ind,parameters,i,fig)


sigma=parameters.problem_variables.sigma;
omega=parameters.problem_variables.omega;
Tf=parameters.problem_variables.Tf;
dt=parameters.problem_variables.dt;
R=parameters.problem_variables.R;
Tevmax=parameters.problem_variables.Tevmax;
x0=parameters.problem_variables.x0;
k=1272.8; %N/m
c=0.1; %N*s/m
mass=0.48; %kg
H=1; %ideal sens
gap=3E-4; %m
C_magnetic=3.73e-6;%N*m^2/A^2
Ib=50E-3;%A

A=[sigma -omega
   omega sigma];

m=readmylisp_to_formal_MLC(ind);
assignin("base","m",m);
m=strrep(m,'S0','y(1)');
m=strrep(m,'S1','y(2)');
% b=@(y)(y); 
% eval(['b=@(y)([0;' m ']);']);
% f=@(t,y) (y(1).^2+y(2).^2+R*sum(b(y).^2)+testt(toc,Tevmax));
J=parameters.badvalue;
try

% [T,Y]=ode45(f,[0:dt:Tf],[x0 ;0]');
%assignin("base","TStart",);
tic
simOut=sim("notLinModel_S.slx",1);
T=simOut.tout;
log1=simOut.logsout{1};
log2=simOut.logsout{2};
log3=simOut.logsout{3};
Y(:,1)=log2.Values.data;
Y(:,2)=log1.Values.data;
bData=log3.Values.data;
J_=Y(:,1).^2+Y(:,2).^2+R*bData.^2;
for i=1:length(Y(:,1))
Y(i,3)=sum(J_(1:i));
end
    J=sum(Y(:,3));
catch
   
   fprintf('crashed\n');
end

if nargin>3
    figure(999)
    subplot(4,1,1)
    plot(T,Y(:,1),'k','linewidth',1.2)
    legend('X_1')
    ylabel('displacment[m]');
    subplot(4,1,2)
    plot(T,Y(:,2),'k','linewidth',1.2)
    legend('X_2')
    ylabel('velocity[m/s]');
    subplot(4,1,3)
    m=strrep(m,'y(1)','y(:,1)');
    m=strrep(m,'y(2)','y(:,2)');
    b=@(y)(y);
    eval(['b=@(y)(' m ');']);
    plot(T,b(Y(:,1:2)),'k','linewidth',1.2)
    ylabel('u')
    subplot(4,1,4)
    plot(T,Y(:,3),'k','linewidth',1.2)
    ylabel('$\int_0^t\frac{dJ}{dt}dt$','interpreter','latex')
    
end