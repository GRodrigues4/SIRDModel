function [t, X] = MSM_SIIIRRRDS(N, alphaA, alphaM, alphaS, gamma, deltaA, deltaM, deltaS, omegaA, omegaM, omegaS, a, tspan)
    
    X0 = [N-a-2; 1;a;1; 0; 0;0;0];
    SIIIRRRDS = @(t, X) [-(alphaA + alphaM + alphaS)*X(1)*sum(X(2:4))/N + omegaA*X(5) + omegaM*X(6) + omegaS*X(7); %dS/dt
                    alphaA*X(1)*sum(X(2:4))/N - deltaA*X(2); %dIA/dt
                    alphaM*X(1)*sum(X(2:4))/N - deltaM*X(3);%dIM/dt
                    alphaS*X(1)*sum(X(2:4))/N - deltaS*X(4) - gamma*X(4);%dIS/dt
                    deltaA*X(2) - omegaA*X(5);%dRA/dt
                    deltaM*X(3) - omegaM*X(6);%dRM/dt
                    deltaS*X(4) - omegaS*X(7);%dRS/dt
                    gamma*X(4)]; %dD/dt
    [t, X] = ode45(SIIIRRRDS, tspan, X0);
    X = X/N;

end