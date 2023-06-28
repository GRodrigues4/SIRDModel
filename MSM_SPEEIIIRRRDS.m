function [t, X] = MSM_SPEEIIIRRRDS(N, alphaA, alphaM, alphaS, gamma, deltaA, deltaM, deltaS, ...
    omegaA, omegaM, omegaS, omegaP, lambdaA, lambdaM, lambdaS, nuS, nuP, sigmaA, sigmaSM, ...
    sigmaSS, sigmaPM, sigmaPS, phi, tau, a, tspan)
    
    X0 = [N-a-2;0;0; 1; a; 1; 0; 0; 0; 0; 0];
    SPEEIIIRRRDS = @(t, X) [-(alphaA + alphaM + alphaS)*X(1)*sum(X(4:6))/N - phi*X(1)*X(2)/N + omegaA*X(7) + omegaM*X(8) + omegaS*X(9) + omegaP*X(11) - tau*X(1); %dS/dt
                    (alphaA + alphaM + alphaS)*X(1)*sum(X(4:6))/N + phi*X(1)*X(2)/N - nuS*X(2); %dES/dt
                    (lambdaA + lambdaM + lambdaS)*X(1)*X(11)/N + phi*X(3)*X(11)/N - nuP*X(3); %dEP/dt
                    sigmaA*nuS*X(2) + sigmaA*nuP*X(3) - deltaA*X(4); %dIA/dt
                    sigmaSM*nuS*X(2) + sigmaPM*nuP*X(3) - deltaM*X(5); %dIM/dt
                    sigmaSS*nuS*X(2) + sigmaPS*nuP*X(3) - deltaS*X(6) - gamma*X(6); %dIS/dt
                    deltaA*X(4) - omegaA*X(7);%dRA/dt
                    deltaM*X(5) - omegaM*X(8);%dRM/dt
                    deltaS*X(6) - omegaS*X(9);%dRS/dt
                    gamma*X(6); %dD/dt
                    tau*X(1) - omegaP*X(11) - (lambdaA + lambdaM + lambdaS)*sum(X(4:6))*X(11)/N - phi*X(3)+X(11)/N]; %dP/dt
    
    [t, X] = ode45(SPEEIIIRRRDS, tspan, X0);
    X = X/N;

end