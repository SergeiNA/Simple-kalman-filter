%% KF [Tracking plane] 25-30
clc;
clear all;

debug = 0;
% Initial states

v_x0 = 280;    % velocity x    ,m
v_y0 = 120;    % velocity y    ,m
x_0  = 4000;   % init x        ,m/s
y_0  = 3000;   % init y        ,m/s
ax   = 2;      % acceleration  ,m/s^2
dt   = 1;      % step          ,s    
% observation

X_obs  =[4000 4260 4550 4860 5110];
Vx_obs =[280  282  285  286  290];

% Process errors in process covariance matrix
dP_x  = 20;       % m
dP_vx = 5;        % m/s

% Obseravation errors
dX   = 25;         % m
dV_x = 6;          %m/s

% I The predicted state

A=[1 dt;0 1];
B=[(dt^2)/2;dt];
X=[x_0;v_x0];
w_r=0;          % errors

X=A*X+B*ax+w_r; % predicted state



if(debug)
% Test I
disp('Initial position and velocity X :');
disp(X);
    for i=1:9
        disp('Time:');
        disp(i*dt);
        X=A*X+B*ax+w_r;
        disp('Position and velocity X :');
        disp(X);
    end
end


% II The initial process covariance matrix
% P=[dP_x^2       dP_x*dP_vx;   Let dP_x*dP_vx=0 then
%    dP_x*dP_vx   dP_vx^2   ];

 P=[dP_x^2       0;   
    0            dP_vx^2   ];
if(debug)
    disp('Initial process covariance matrix');
    disp(P);
end

% III The predict process covariance matrix
Q=0;    % errors
P=A*P*A'+Q;

P(1,2)=0;   % We will simply ignore 2 nd diaganal
P(2,1)=0;

if(debug)
    disp('Predict process covariance matrix');
    disp(P);
end

% IV Calculate the Kalman Gain
R=[dX^2 0
   0    dV_x^2];          % Errors
H=eye(2);      % Needs to convert P into K, P has the same size with K
               % Thats why H is identity matrix
K= (P*H')/(H*P*H'+R);
if(debug)
    disp('Kalman Gain matrix');
    disp(K);
end

