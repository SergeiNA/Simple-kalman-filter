%% Motion model 
% general equations
% 1) X=X_ini+V_ini*t+(1/2)*(t^2)*g
% we can rewrite as
% 2) X_st(t)=A*X_st(t-1)+B*u(t) where
% A=[1 dt;0 1] and B=[(dt^2)/2;dt]
% X=[X_ini;V_ini]; if we multiply these matrix we will get exact the
% same equation
clear all;
clc;
g=9.8;
X_ini=20;
V_ini=0;

dt=10;
A=[1 dt;0 1];
B=[(dt^2)/2;dt];
X=[X_ini;V_ini];
for i=1:10

    disp(strcat('time :',num2str(i*dt)));
    disp(X);
    X=A*X+B*g;
end
disp(X);