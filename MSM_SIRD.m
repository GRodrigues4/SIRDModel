function [t, X] = MSM_SIRD(N, alpha, gamma, delta, a, tspan)

    X0 = [N-a; a; 0; 0];
    SIRD = @(t, X) [-alpha*X(1)*X(2)/N; %dS/dt
                    alpha*X(1)*X(2)/N - delta*X(2) - gamma*X(2); %dI/dt
                    delta*X(2);%dR/dt
                    gamma*X(2)]; %dD/dt
    [t, X] = ode45(SIRD, tspan, X0);
    X = X/N;
end