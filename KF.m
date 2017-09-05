%% Simple kalman filter
% KG     - kalman gain
% ERR_est  - error in estimate
% ERR_mea  - error in measurment

% EST_cur  - current estimate
% EST_perv - previous estimate

% Initialization
T_temp =72;         % True temperature
EST_ini = 71;       % initial temperature
ERR_ini = 2;        
MEA_ini = 75;       % initial measurment
ERR_mea=4;

MEA=[75 71 70 74 73 75];
EST=EST_ini;
ERR_est=ERR_ini;

for i=1:5
    KG=ERR_est/(ERR_est+ERR_mea);
    EST=EST+KG*(MEA(i)-EST);
    ERR_est=(1-KG)*ERR_est;
end

display(abs(T_temp-EST));

