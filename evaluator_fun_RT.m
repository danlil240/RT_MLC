
function J=evaluator_fun_RT(ind,parameters,i,fig)
m=readmylisp_to_formal_MLC(ind);
phisical=0;
if phisical
    m=['3000*S0+7.3*S1+',m];
    m=strrep(m,'S0','s0');
    m=strrep(m,'S1','s1');
    m=strrep(m,'.*','*');
else
    Tf=parameters.problem_variables.Tf;
    dt=parameters.problem_variables.dt;
    Tevmax=parameters.problem_variables.Tevmax;
    x0=parameters.problem_variables.x0;
    Q=parameters.problem_variables.Q;
    R=parameters.problem_variables.R;m
    m=['3000*S0+7.3*S1+',m];
    m=strrep(m,'S0','y(1)');
    m=strrep(m,'S1','y(2)');
    b=@(y)(y);
    eval(['b=@(y)(' m ');']);
end
J=parameters.badvalue;
try
    if phisical==1
        J=PhisicalModel(m)
    else
        tic
        %   Wnoise =Wnoise_LPF(dt,Tf)*300;
        stepF=step_BPF(dt,Tf);
        %   excitation=@(T) 0.005*sin(100*2*pi*T);
        %   excitation=@(T) Wnoise(floor(T/dt+1));
        %   excitation=@(T) 0;
        excitation=@(T) stepF(floor(T/dt+1));

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
    %     dataFile = fopen('new.txt','r');
    %     Y = textscan(dataFile,'%f%f%f','Delimiter',{'\t',','}, 'CollectOutput',1);
    %     fclose(dataFile);
    if phisical==0
        figure(999)
        subplot(3,1,1)
        plot(T,Y(:,1),'linewidth',1.2)
        legend({'MLC'})
        ylabel('displacment[m]');
        title({"b = " + m," "},'FontSize',8 )
        hold off

        subplot(3,1,2)
        plot(T,Y(:,2),'linewidth',1.2)
        legend({'MLC'})
        ylabel('velocity[m/s]');
        hold off

        subplot(3,1,3)
        plot(T,Y(:,3),'linewidth',1.2)
        ylabel('u')
        legend({'MLC'})
    end
end