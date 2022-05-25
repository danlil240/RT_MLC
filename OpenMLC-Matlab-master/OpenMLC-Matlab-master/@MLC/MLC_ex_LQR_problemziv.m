
% 
clear all
close all
clc
% 


% Define system matrices
sigma = 1; omega = 1;   % Unstable oscillator parameters
A = [sigma -omega;      % Dynamics
    omega sigma];
B = [0; 1];             % Actuation on second state
C = [1 0;               % Full-state measurements
    0 1];
D = [0; 0];              % No feedthrough term
sys = ss(A,B,C,D);      % Continuous-time state-space system

% Compute LQR controller
Q = eye(2);             % State cost is 2x2 identity matrix
R = 1;                  % Actuation cost is 1
[K,S,e] = lqr(A,B,Q,R); % Optimal gain matrix K from LQR

% Simulation closed-loop system
dt = 0.001;
Acl = A-B*K;            % Closed-loop dynamics
Bcl = [0; 0];           % No input after closing-loop
sysK = ss(Acl,Bcl,C,D); % Closed-loop syste,
[s,t] = initial(sysK,[1;0],0:dt:10);    % Intial condition response

% Compute cost function
b = -K*s';              % Actuation signal
J(1) = 0;               % Initialize cost J=0
% For each dt, integrate cost function
for k=2:length(t)
    J(k) = J(k-1)+dt*(s(k-1,:)*Q*s(k-1,:)' + R*b(k-1)^2);
end

figure(1)
subplot(211); plot(t,s); ylabel('states'); legend('x1','x2')
subplot(212);plot(t,J); ylabel('cost function')
% 
% mlc=MLC('MLC_ex_LQR_problem');  % Creates the MLC problem
% mlc.go(50);                     % Runs MLC for 50 generetions
% mlc.show_best_indiv        % Displays the results
% 
% open('MLC_evaluator_LQR')
