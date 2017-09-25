%% KF [Tracking plane] 35-XX
clc;
clear all;
close all;
% Initial states
%--------------------------------------------------------------------------
v_x0 = 280;    % velocity x    ,m
v_y0 = 120;    % velocity y    ,m
x_0  = 4000;   % init x        ,m/s
y_0  = 3000;   % init y        ,m/s
ax   = 2;      % acceleration  ,m/s^2
dt   = 1;      % step          ,s    
% observation
%--------------------------------------------------------------------------
X_obs  =[4000 4260 4550 4860 5110];
Vx_obs =[280  282  285  286  290];

% Process errors in process covariance matrix
%--------------------------------------------------------------------------
dP_x  = 20;       % m
dP_vx = 5;        % m/s

% Obseravation errors
%--------------------------------------------------------------------------
dX   = 25;         % m
dV_x = 6;          %m/s

% I The predicted state
%--------------------------------------------------------------------------
A=[1 dt;0 1];
B=[(dt^2)/2;dt];
X=[x_0;v_x0];
w_r=0;          % errors
Q=0;
Z=0;
C=[1 0;
   0 1];
H=eye(2);
I=eye(2);
P=[dP_x^2       0;   
   0            dP_vx^2   ];

% vectors for data
%--------------------------------------------------------------------------
Xvec_kalman=zeros(2,5);
Xvec_estimate=zeros(2,5);
Xvec_observation=zeros(2,5);

% calculate predicted values
%--------------------------------------------------------------------------
X=A*X+B*ax+w_r;
Xvec_kalman(1,1)=X(1,1);
Xvec_kalman(2,1)=X(2,1);

Y=C*[X_obs(1);Vx_obs(1)]+Z;
Xvec_observation(1,1)=Y(1,1);
Xvec_observation(2,1)=Y(2,1);

% Kalman filter main body
%--------------------------------------------------------------------------
for t=2:5
    if(t>2)                         % because of we calculate first value 
        X=A*X+B*ax+w_r;             % outside of cycle
    end
    P=A*P*A'+Q;
    P(1,2)=0;                       % We will simply ignore 2 nd diaganal
    P(2,1)=0;
    R=[dX^2 0
       0    dV_x^2];                % Errors
    K= (P*H')/(H*P*H'+R);
    Y=C*[X_obs(t);Vx_obs(t)]+Z;
    
    Xvec_observation(1,t)=Y(1,1);
    Xvec_observation(2,t)=Y(2,1);
    
    X=X+K*(Y-H*X);
    P = (I-K*H)*P;
    
    Xvec_kalman(1,t)=X(1,1);
    Xvec_kalman(2,t)=X(2,1);
end
%repeat initial states for estimate cycle
%--------------------------------------------------------------------------
A=[1 dt;0 1];
B=[(dt^2)/2;dt];
X=[x_0;v_x0];
w_r=0;          % errors
Q=0;
Z=0;
C=[1 0;
   0 1];
H=eye(2);
I=eye(2);
P=[dP_x^2       0;   
   0            dP_vx^2   ];
% estimate cycle
%--------------------------------------------------------------------------
for t=1:5
    X=A*X+B*ax+w_r;
    Xvec_estimate(1,t)=X(1,1);
    Xvec_estimate(2,t)=X(2,1);
end
% Delete some counts to obtain the same size
%--------------------------------------------------------------------------
Xvec_observation(:,1)=[];
Xvec_kalman(:,1)=[];
Xvec_estimate(:,5)=[];

% Display all values
%--------------------------------------------------------------------------
disp('Kalman :');
disp(Xvec_kalman);
disp('Estimate :');
disp(Xvec_estimate);
disp('Observation : ');
disp(Xvec_observation);

% Plot figures
%--------------------------------------------------------------------------
 
figure (1)
hold on;
grid on;
plot(1:4,Xvec_kalman(1,:),'b','LineWidth',1);
plot(1:4,Xvec_estimate(1,:),'g','LineWidth',1);
plot(1:4,Xvec_observation(1,:),'r','LineWidth',1);
xlabel('time, seconds');
ylabel('X,meters');
title('Coordinate');
legend('Kalman','Estimate','Observation');
hold off


figure (2)
grid on;
hold on
plot(1:4,Xvec_kalman(2,:),'b','LineWidth',1);
plot(1:4,Xvec_estimate(2,:),'g','LineWidth',1);
plot(1:4,Xvec_observation(2,:),'r','LineWidth',1);
xlabel('time, seconds');
ylabel('velocity,m/s^2');
title('Velocity');
legend('Kalman','Estimate','Observation');
hold off