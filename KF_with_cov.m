% KF with process variation standart diviation

qx=0.5;
qx_v=0.2;

x0=50;
v0=5;
a0=2;

P=[qx^2    0;           % If the estimate error for the one variable x (position)
   0       qx_v^2   ];  % is completely independent of the other variable v (velocity)
                        % then the covariance elements=0
dt=10;
A=[1 dt;0 1];
B=[(dt^2)/2;dt];
X=[x0;v0];
for i=1:10

    disp(i*dt);
    disp(X);
    X=A*X+B*a0;
end
disp(X);