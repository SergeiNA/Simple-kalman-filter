% two dimentional example
% we have x & y so that:
clear all;
clc;
dt=1;
A_m=[1 0 dt 0;
     0 1 0 dt;
     0 0 1 0 ;
     0 0 0 1 ];
 B_m=[(dt^2)/2  0      ;
      0        (dt^2)/2;
      dt        0      ;  
      0         dt     ];
  X_ini  = 10;
  Vx_ini = 4;
  Y_ini  = 4;
  Vy_ini = 6;
  a_x    = 12;
  a_y    = 4;
  
  X_m=[ X_ini;
      Y_ini;
      Vx_ini;
      Vy_ini];
  
  u=[a_x; a_y];
  
for i=1:10
    disp('time:');
    disp(i*dt);
    disp('state:');
    disp(X_m);
    X_m=A_m*X_m+B_m*u;
end