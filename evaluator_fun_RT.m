
function J=evaluator_fun_RT(ind,parameters,i,fig)
m=readmylisp_to_formal_MLC(ind);
phisical=1;
if phisical==1
    m=['2500*S0+4*S1+',m];
    m=strrep(m,'S0','s0');
    m=strrep(m,'S1','s1');
    m=strrep(m,'.*','*');
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
    if phisical==1
        pause(1)
        m1='3300*s0+7.3*s1';
        [T1,Y1]=PhisicalModel(m1);
        J1=Y1(end,3)
    end
    
    
    figure(999)
    subplot(4,1,1)
    plot(T,Y(:,1),'linewidth',1.2)
    hold on
    plot(T1,Y1(:,1),'linewidth',1.2)
    legend({'MLC','LQR'})
    ylabel('displacment[m]');
    title(m);
    hold off
    
    subplot(4,1,2)
    plot(T,Y(:,2),'linewidth',1.2)
    hold on
    plot(T1,Y1(:,2),'linewidth',1.2)
    legend({'MLC','LQR'})
    ylabel('velocity[m/s]');
    hold off
    
    subplot(4,1,3)
    plot(T,Y(:,3),'linewidth',1.2)
    hold on
    plot(T1,Y1(:,3),'linewidth',1.2)
    ylabel('j')
    legend({'MLC','LQR'})
    hold off
    
    subplot(4,1,4)
    plot(T,Y(:,4),'linewidth',1.2)
    hold on
    plot(T1,Y1(:,4),'linewidth',1.2)
    ylabel('u')
    legend({'MLC','LQR'})
    hold off
end