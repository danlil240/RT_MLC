
function J=evaluator_fun_RT(ind,parameters,i,fig)
m=readmylisp_to_formal_MLC(ind);
phisical=1;
if phisical==1
    m=['2500*S0+4*S1+',m];
    m=strrep(m,'S0','s0');r
    m=strrep(m,'S1','s1');
    m=strrep(m,'.*','*')
else
    Tf=parameters.problem_variables.Tf;
    dt=parameters.problem_variables.dt;
    Tevmax=parameters.problem_variables.Tevmax;
    x0=parameters.problem_variables.x0;
    Q=parameters.problem_variables.Q;
    R=parameters.problem_variables.R;
    m=strrep(m,'S0','y(1)');
    m=strrep(m,'S1','y(2)');
    b=@(y)(y);
    eval(['b=@(y)(' m ');']);
end
J=parameters.badvalue;
try
    if phisical==1
        [T,Y]=PhisicalModel(m);
        J=Y(end,3)
    else
        tic
        Wnoise =Wnoise_LPF(dt,Tf)*300;
        %   stepF=step_BPF(dt,Tf);
        %   excitation=@(T) 0.005*sin(100*2*pi*T);
        excitation=@(T) Wnoise(floor(T/dt+1));
        %   excitation=@(T) 0;
        %   excitation=@(T) stepF(floor(T/dt+1));
        
        f=@(T,Y) Dynamic_model_fun(T,Y,b(Y(1:2)),excitation(T),Q,R,Tevmax);
        opts = odeset('RelTol',1e-13,'AbsTol',1e-10);
        [T,Y]=ode45(f,[0:dt:Tf],x0,opts);
        if T(end)==Tf
            J=Y(end,3);
        end
    end
catch
    fprintf('crashed\n');
end

if nargin>3
    assignin('base','T_best',T)
    assignin('base','Y_best',Y)
    if phisical==1
        pause(1)
        m1='3300*s0+7.3*s1';
        [T1,Y1]=PhisicalModel(m1);
        J1=Y1(end,3)
    end
    try
    start=find(T>0.23,1);
    final=find(T>0.4,1);
    

    figure(999)
    subplot(4,1,1)
    plot(T(start:final)-0.23,Y(start:final,1),'linewidth',1.2)
    hold on
    plot(T1(start:final)-0.23,Y1(start:final,1),'linewidth',1.2)
    legend({'MLC','LQR'})
    ylabel('Displacment[m]');
%     title(m);
%     xlim([0.23,0.4])
    hold off
    
    subplot(4,1,2)
    plot(T(start:final)-0.23,Y(start:final,2),'linewidth',1.2)
    hold on
    plot(T1(start:final)-0.23,Y1(start:final,2),'linewidth',1.2)
    legend({'MLC','LQR'})
    ylabel('Velocity[m/s]');
%     xlim([0.23,0.4])
    hold off
    
    subplot(4,1,3)
    plot(T(start:final)-0.23,Y(start:final,3),'linewidth',1.2)
    hold on
    plot(T1(start:final)-0.23,Y1(start:final,3),'linewidth',1.2)
%     str = '$$ \int_{0}^{t} J dt $$';
%     ylabel(str,'Interpreter','latex')
    ylabel('J')
    legend({'MLC','LQR'})
%     xlim([0.23,0.4])
    hold off
    
    subplot(4,1,4)
    plot(T(start:final)-0.23,Y(start:final,4),'linewidth',1.2)
    hold on
    plot(T1(start:final)-0.23,Y1(start:final,4),'linewidth',1.2)
    ylabel('u[A]')
    legend({'MLC','LQR'})
%     xlim([0.23,0.4])
    hold off
    catch
        disp('Data Error')
    end
end