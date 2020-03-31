% Solves Van der Pols equations using ode45 and odeRal and plots solutions.
% lambda - Damping parameter to VdP_ODE
% y_init - Initial conditions for VdP_ODE
% tspan - Interval for independent variable t.
% h - Step size for odeRal

lambda = 2;
y_init = [1, 0];
tspan = [0, 25];
h = 0.1;

% ========================================================================

f = @(t, y)VdP_ODE(t, y, lambda);
[t, y] = ode45(f, tspan, y_init);
[tr, yr] = odeRal(f, tspan, y_init, h);

plot(t,y(:,1),'k', t,y(:,2),'--k',... 
     tr,yr(:,1),'r', tr,yr(:,2),'--r');

xlabel('{\it t} (time)');
ylabel('{\it x} (position),{\it dx/dt}');
title(sprintf('Van der Pol oscillator, \x03bb = %0.3f', labmda));
lstr = sprintf('odeRal,  h = %0.3f', h);
legend('{\it x}, ode45', '{\it dx/dt}, ode45',... 
       ['{\it x}, ',lstr], ['{\it dx/dt}, ',lstr]);