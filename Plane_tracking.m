%% KF [Tracking plane] 25-35
clc;
clear all;
% debuging
%--------------------------------------------------------------------------
debug = 1;
lvl1=0;
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

X=A*X+B*ax+w_r; % predicted state

if(debug)
    disp('Initial position and velocity X :');
    disp(X);
end

% Test I
if(debug*lvl1)
disp('Initial position and velocity X:');
disp(X);
    for i=1:9
        disp('Time:');
        disp(i*dt);
        X=A*X+B*ax+w_r;
        disp('Position and velocity X:');
        disp(X);
    end
end


% II The initial process covariance matrix
% P=[dP_x^2       dP_x*dP_vx;   Let dP_x*dP_vx=0 then
%    dP_x*dP_vx   dP_vx^2   ];
%--------------------------------------------------------------------------
 P=[dP_x^2       0;   
    0            dP_vx^2   ];

if(debug)
    disp('Initial process covariance matrix: ');
    disp(P);
end

% III The predict process covariance matrix
%--------------------------------------------------------------------------
Q=0;                % errors
P=A*P*A'+Q;

P(1,2)=0;           % We will simply ignore 2 nd diaganal
P(2,1)=0;

if(debug)
    disp('Predict process covariance matrix: ');
    disp(P);
end

% IV Calculate the Kalman Gain
%--------------------------------------------------------------------------
R=[dX^2 0
   0    dV_x^2];    % Errors
H=eye(2);           % Needs to convert P into K, P has the same size with K
                    % Thats why H is identity matrix
                    % R - errors in measurment
K= (P*H')/(H*P*H'+R);
if(debug)
    disp('Kalman Gain matrix: ');
    disp(K);
end

% V The new observation Yk=C*Yk+Zk; Z=0
% we take X_obs(1) and Vx_obs(1)
%--------------------------------------------------------------------------
C=[1 0;
   0 1];
Z=0;

Y=C*[X_obs(2);Vx_obs(2)]+Z;

if(debug)
    disp('The new observation matrix: ');
    disp(Y);
end

% VI Calculate the current state X=X+K*[Y-H*X]
%--------------------------------------------------------------------------
X=X+K*(Y-H*X);

if(debug)
    disp('The current state matrix: ');
    disp(X);
end

% Update the process covariance matrix
%--------------------------------------------------------------------------
I=eye(2);
P = (I-K*H)*P;

if(debug)
    disp('Updated process covariance matrix: ');
    disp(P);
end

% VII Current become pervious
% just start the program with the begining
% X(k-1)=X(k) and P(k-1)=P(k)
% this is end of first iteration
%--------------------------------------------------------------------------
% NEXT -> WRITE A NEW PROGRAM WITH CYCLE
