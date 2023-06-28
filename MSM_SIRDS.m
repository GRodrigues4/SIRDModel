function [t, X] = MSM_SIRDS(N, alpha, omega, delta, gamma, a, tspan)

    X0 = [N-a; a; 0; 0];
    SIRDS = @(t, X) [-alpha*X(1)*X(2)/N + omega*X(3) ; %dS/dt
                    alpha*X(1)*X(2)/N - delta*X(2) - gamma*X(2); %dI/dt
                    delta*X(2) - omega*X(3);%dR/dt
                    gamma*X(2)]; %dD/dt
    [t, X] = ode45(SIRDS, tspan, X0);
    X = X/N;
end