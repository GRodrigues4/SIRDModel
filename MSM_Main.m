close all; clearvars; clc;
% Define parameter values

alpha = 0.664;      % Infection Rate
gamma = 0.1;        % Mortality Rate
phi = 0.7;          % Exposed rate 
nu = 0.83;          % Exposed infected rate 
alphaP = 0.0373;    % Infection Rate from Protected

deltaA = 0.333;     % Recovery Rate (Asymptomatic)
deltaM = 0.2;       % Recovery Rate (Mild symptoms)
deltaS = 0.1429;    % Recovery Rate (Severe symptoms)
delta = 0.2;        % Recovery Rate (TOTAL)

omegaA = 0.0111;    % Immunity loss Rate (Recovered - Asymptomatic)
omegaM = 0.0056;    % Immunity loss Rate (Recovered - Mild symptoms)
omegaS = 0.0028;    % Immunity loss Rate (Recovered - Severe symptoms)
omegaP = 0.0056;    % Protected to Susceptible Rate
omega = 0.0028;     % Immunity Rate (TOTAL)   

nuP = 0.31;         % Exposed (from Protected) to Infected rate    

sigmaA = 0.3;       % Portion of Infected that are Asymptomatic (From both vaccinated and not vaccinated Exposed)
sigmaSM = 0.65;     % Portion of Infected with Mild symptoms (From not vaccinated Exposed)
sigmaSS = 0.05;     % Portion of Infected with Severe symptoms (From not vaccinated Exposed)
sigmaPM = 0.69;     % Portion of Infected with Mild symptoms (From vaccinated Exposed)
sigmaPS = 0.01;     % Portion of Infected with Severe symptoms (From vaccinated Exposed)

tau = 0.005;        % Vaccination Rate

N = 4000;           % Total Population
a = 2;              % Initial Number of Infected People

% Define time span
tspan = [1 100];


%% SIRD


[t_SIRD, X_SIRD] = MSM_SIRD(N, alpha, gamma, delta, a, tspan);

figure;
plot(t_SIRD, X_SIRD(:, 1), 'b:', t_SIRD, X_SIRD(:, 2), 'r--', t_SIRD, X_SIRD(:, 3), 'c-.', t_SIRD, X_SIRD(:,4), "m-." ,'LineWidth', 2);
xlabel('Time (days)');
ylabel('Population');
legend('Susceptible', 'Infected', 'Recovered', 'Deaths');
title('SIRD Model Simulation');

%% SIRDS


[t_SIRDS, X_SIRDS] = MSM_SIRDS(N, alpha, omega, delta, gamma, a, tspan);

figure;
plot(t_SIRDS, X_SIRDS(:, 1), 'b:', t_SIRDS, X_SIRDS(:, 2), 'r--', t_SIRDS, X_SIRDS(:, 3), 'c-.', t_SIRDS, X_SIRDS(:,4), "m-." ,'LineWidth', 2);
xlabel('Time (days)');
ylabel('Population');
legend('Susceptible', 'Infected', 'Recovered', 'Deaths');
title('SIRDS Model Simulation');


%% SEIRDS


[t_SEIRDS, X_SEIRDS] = MSM_SEIRDS(N, alpha, phi, nu, gamma, delta,omega, a, tspan);
figure;
plot(t_SEIRDS, X_SEIRDS(:, 1), 'b:', t_SEIRDS, X_SEIRDS(:, 2), 'y--', t_SEIRDS, X_SEIRDS(:, 3), 'r--', t_SEIRDS, X_SEIRDS(:, 4), 'c-.',t_SEIRDS, X_SEIRDS(:,5), "m-." , 'LineWidth', 2);
xlabel('Time (days)');
ylabel('Population');
legend('Susceptible', 'Exposed', 'Infected', 'Recovered', "Deaths");
title('SEIRDS Model Simulation');

%% SIIIRRRDS


[t_SIIIRRRDS, X_SIIIRRRDS] =MSM_SIIIRRRDS(N,  alpha*sigmaA, alpha*sigmaSM, alpha*sigmaSS, gamma, deltaA, deltaM, deltaS, ...
    omegaA, omegaM, omegaS, a, tspan);

figure;
plot(t_SIIIRRRDS, X_SIIIRRRDS(:,1),"b:",t_SIIIRRRDS, sum(X_SIIIRRRDS(:,2:4),2),"r--",t_SIIIRRRDS, sum(X_SIIIRRRDS(:,5:7),2), "c-.",t_SIIIRRRDS, X_SIIIRRRDS(:,8), "m-.", 'LineWidth', 2)
xlabel('Time (days)');
ylabel('Population');
legend('Susceptible', 'Infected', 'Recovered');
title('SIIIRRRDS Model Simulation');
% figure;
% plot(t_SIIIRRRDS, X_SIIIRRRDS(:,1),"b:",t_SIIIRRRDS, X_SIIIRRRDS(:,3),"r--",t_SIIIRRRDS, X_SIIIRRRDS(:,6), "c-.", 'LineWidth', 2)
% xlabel('Time (days)');
% ylabel('Population');
% legend('Susceptible', 'Infected', 'Recovered');
% title('SIIIRRRD Model Simulation (Mild symptoms cases)');
% figure;
% plot(t_SIIIRRRDS, X_SIIIRRRDS(:,1),"b:",t_SIIIRRRDS, X_SIIIRRRDS(:,4),"r--",t_SIIIRRRDS, X_SIIIRRRDS(:,7), "c-.", t_SIIIRRRDS, X_SIIIRRRDS(:,8), "m-.", 'LineWidth', 2)
% xlabel('Time (days)');
% ylabel('Population');
% legend('Susceptible', 'Infected', 'Recovered', "Deaths");
% title('SIIIRRRD Model Simulation (Severe symptoms cases)');

%% SPIIIRRRDS


[t_SPIIIRRRDS, X_SPIIIRRRDS] = MSM_SPIIIRRRDS(N, alpha*sigmaA, alpha*sigmaSM, alpha*sigmaSS, gamma, deltaA, deltaM, deltaS, ...
    omegaA, omegaM, omegaS, omegaP, alphaP*sigmaA, alphaP*sigmaPM, alphaP*sigmaPS, tau, a, tspan);
figure;
plot(t_SPIIIRRRDS, X_SPIIIRRRDS(:,1),"b:",t_SPIIIRRRDS, sum(X_SPIIIRRRDS(:,2:4),2),"r--",t_SPIIIRRRDS, sum(X_SPIIIRRRDS(:,5:7),2), "c-.", t_SPIIIRRRDS, X_SPIIIRRRDS(:,8),"m-.", t_SPIIIRRRDS, X_SPIIIRRRDS(:,9), "g--", 'LineWidth', 2)
xlabel('Time (days)');
ylabel('Population');
legend('Susceptible', 'Infected', 'Recovered', "Deaths", "Protected");
title('SPIIIRRRDS Model Simulation');
%figure;
% plot(t_SPIIIRRRDS, X_SPIIIRRRDS(:,1),"b:",t_SPIIIRRRDS, X_SPIIIRRRDS(:,3),"r--",t_SPIIIRRRDS, X_SPIIIRRRDS(:,6), "c-.", t_SPIIIRRRDS, X_SPIIIRRRDS(:,9),"g--", 'LineWidth', 2)
% xlabel('Time (days)');
% ylabel('Population');
% legend('Susceptible', 'Infected', 'Recovered', "Protected");
% title('SPIIIRRRD Model Simulation (Mild symptoms cases)');
% figure;
% plot(t_SPIIIRRRDS, X_SPIIIRRRDS(:,1),"b:",t_SPIIIRRRDS, X_SPIIIRRRDS(:,4),"r--",t_SPIIIRRRDS, X_SPIIIRRRDS(:,7), "c-.", t_SPIIIRRRDS, X_SPIIIRRRDS(:,8),"m-.", t_SPIIIRRRDS, X_SPIIIRRRDS(:,9), "g--", 'LineWidth', 2)
% xlabel('Time (days)');
% ylabel('Population');
% legend('Susceptible', 'Infected', 'Recovered', "Deaths", "Protected");
% title('SPIIIRRRD Model Simulation (Severe symptoms cases)');

%% SPEEIIIRRRDS


[t_SPEEIIIRRRDS, X_SPEEIIIRRRDS] = MSM_SPEEIIIRRRDS(N, alpha*sigmaA, alpha*sigmaSM, alpha*sigmaSS, gamma, deltaA, deltaM, deltaS, ...
    omegaA, omegaM, omegaS, omegaP, alphaP*sigmaA, alphaP*sigmaPM, alphaP*sigmaPS, nu, nuP, sigmaA, sigmaSM, ...
    sigmaSS, sigmaPM, sigmaPS, phi, tau, a, tspan);

figure;
plot(t_SPEEIIIRRRDS, X_SPEEIIIRRRDS(:,1),"b:",t_SPEEIIIRRRDS,sum(X_SPEEIIIRRRDS(:,2:3),2), "y--" ,t_SPEEIIIRRRDS, sum(X_SPEEIIIRRRDS(:,4:6),2),"r--",t_SPEEIIIRRRDS, sum(X_SPEEIIIRRRDS(:,7:9),2), "c-.", t_SPEEIIIRRRDS, X_SPEEIIIRRRDS(:,10),"m-.", t_SPEEIIIRRRDS, X_SPEEIIIRRRDS(:,11), "g--", 'LineWidth', 2)
xlabel('Time (days)');
ylabel('Population');
legend('Susceptible',"Exposed (Total)" ,'Infected', 'Recovered', "Deaths", "Protected");
title('SPEEIIIRRRDS Model Simulation');
% figure;
% plot(t_SPEEIIIRRRDS, X_SPEEIIIRRRDS(:,1),"b:",t_SPEEIIIRRRDS, sum(X_SPEEIIIRRRDS(:,2:3),2), "y", t_SPEEIIIRRRDS, X_SPEEIIIRRRDS(:,5),"r--",t_SPEEIIIRRRDS, X_SPEEIIIRRRDS(:,8), "c-.", t_SPEEIIIRRRDS, X_SPEEIIIRRRDS(:,11),"g--", 'LineWidth', 2)
% xlabel('Time (days)');
% ylabel('Population');
% legend('Susceptible',"Exposed (Total)" , 'Infected', 'Recovered', "Protected");
% title('SPEEIIIRRRD Model Simulation (Mild symptoms cases)');
% figure;
% plot(t_SPEEIIIRRRDS, X_SPEEIIIRRRDS(:,1),"b:",t_SPEEIIIRRRDS,sum(X_SPEEIIIRRRDS(:,2:3),2), "y" ,t_SPEEIIIRRRDS, X_SPEEIIIRRRDS(:,6),"r--",t_SPEEIIIRRRDS, X_SPEEIIIRRRDS(:,9), "c-.", t_SPEEIIIRRRDS, X_SPEEIIIRRRDS(:,10),"m-.", t_SPEEIIIRRRDS, X_SPEEIIIRRRDS(:,11), "g--", 'LineWidth', 2)
% xlabel('Time (days)');
% ylabel('Population');
% legend('Susceptible', "Exposed (Total)" , 'Infected', 'Recovered', "Deaths", "Protected");
% title('SPEEIIIRRRD Model Simulation (Severe symptoms cases)');

