clear
load('exp4LQR.mat');
Y_LQR=Y;
load('exp3.mat');
Y_1=Y_best;
load('exp2sin.mat');
Y_sin=Y_best;
start=find(T>0.23,1);
final=find(T>0.4,1);


figure(999)
subplot(4,1,1)
plot(T(start:final)-0.23,Y_LQR(start:final,1),'linewidth',1.2)
hold on
plot(T1(start:final)-0.23,Y_1(start:final,1),'linewidth',1.2)
plot(T1(start:final)-0.23,Y_sin(start:final,1),'linewidth',1.2)
legend({'LQR','MLC[gain,add]','MLC[gain,add,sin]'})
ylabel('Displacment[m]');
%     title(m);
%     xlim([0.23,0.4])
hold off

subplot(4,1,2)
plot(T(start:final)-0.23,Y_LQR(start:final,2),'linewidth',1.2)
hold on
plot(T1(start:final)-0.23,Y_1(start:final,2),'linewidth',1.2)
plot(T1(start:final)-0.23,Y_sin(start:final,2),'linewidth',1.2)
legend({'LQR','MLC[gain,add]','MLC[gain,add,sin]'})
ylabel('Velocity[m/s]');
%     xlim([0.23,0.4])
hold off

subplot(4,1,3)
plot(T(start:final)-0.23,Y_LQR(start:final,3),'linewidth',1.2)
hold on
plot(T1(start:final)-0.23,Y_1(start:final,3),'linewidth',1.2)
plot(T1(start:final)-0.23,Y_sin(start:final,3),'linewidth',1.2)
%     str = '$$ \int_{0}^{t} J dt $$';
%     ylabel(str,'Interpreter','latex')
ylabel('J')
legend({'LQR','MLC[gain,add]','MLC[gain,add,sin]'})
%     xlim([0.23,0.4])
hold off

subplot(4,1,4)
plot(T(start:final)-0.23,Y_LQR(start:final,4),'linewidth',1.2)
hold on
plot(T1(start:final)-0.23,Y_1(start:final,4),'linewidth',1.2)
plot(T1(start:final)-0.23,Y_sin(start:final,4),'linewidth',1.2)
ylabel('u[A]')
legend({'LQR','MLC[gain,add]','MLC[gain,add,sin]'})
%     xlim([0.23,0.4])
hold off
xlabel('Time[s]')