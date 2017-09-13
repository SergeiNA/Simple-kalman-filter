% Variance, covariance and standartion didviation calculate
% X - vec of x meas
% Y - vec of Y meas
% Z - vec of Z meas

%% way 1
% measurment
clear all;
clc;
N=5;
% X=randi([1,4],1,N);
% Y=randi([4,8],1,N);
% Z=randi([3,9],1,N);
X= [90 90 60 30 30];
Y =[80 60 50 40 20];
Z= [40 80 70 70 90];
% averege of measurment
X_av=sum(X)/N;
Y_av=sum(Y)/N;
Z_av=sum(Z)/N;
% deviation
X_dev=-X+X_av;
Y_dev=-Y+Y_av;
Z_dev=-Z+Z_av;

% squared deviation
Xsq_dev=X_dev.^2;
Ysq_dev=Y_dev.^2;
Zsq_dev=Z_dev.^2;
% variance
X_vari=sum(Xsq_dev)/N;
Y_vari=sum(Ysq_dev)/N;
Z_vari=sum(Zsq_dev)/N;

% covariance
XY_cov=sum(X_dev.*Y_dev)/N;
XZ_cov=sum(X_dev.*Z_dev)/N;
YZ_cov=sum(Y_dev.*Z_dev)/N;

% standart deviation
X_sd=sqrt(X_vari);
Y_sd=sqrt(Y_vari);
Z_sd=sqrt(Z_vari);


M_cov=[X_vari XY_cov XZ_cov;
       XY_cov Y_vari YZ_cov;
       XZ_cov YZ_cov Z_vari];


display(M_cov);

% way 2;
% avr = M-1*M/N
% COV = avt'*avr/N;
M= [X' Y' Z'];
avr=M-ones(N)*M./N;

M2_cov=avr'*avr./N;
display(M2_cov);
