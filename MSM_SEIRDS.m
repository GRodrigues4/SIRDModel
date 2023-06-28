function [t, X] = MSM_SEIRDS(N, alpha, phi, nu, gamma, delta,omega, a, tspan)
    
    X0 = [N - a; 0; a; 0; 0];
    SEIR = @(t, X) [-alpha*X(1)*X(3)/N - phi*X(1)*X(2)/N + omega*X(4); %dS/dt
                    alpha*X(1)*X(3)/N + phi*X(1)*X(2)/N - nu*X(2); %dE/dt
                    nu*X(2) - delta*X(3) - gamma*X(3); %dI/dt
                    delta*X(3) - omega*X(4); %dR/dt
                    gamma*X(3)]; %dD/dt
    
    [t, X] = ode45(SEIR, tspan, X0);
    X = X/N;
end
