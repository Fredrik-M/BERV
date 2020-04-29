%SDElab1 Geometric Brownian Motion.
%
% In this Lab you will examine Geometric Brownian Motion (GBM). This
% is a basic stochastic model in SDE-form with many applications,
% e.g., in building up more advanced models of financial assets.
% 
% The code will 
% - produce a collection of exact sample outcomes of the GBM
%   also compute the exact mean and variance. 
% - produce one approximate sample using an Euler (-Maruyama) 
%   discretization  

% S. Engblom Sept 2018, modified E. Larsson and S. Pålsson Febr 2019.

%% Setup
% https://en.wikipedia.org/wiki/Geometric_Brownian_motion
close all
clear
% the model here is dX(t) = mu*X(t)dt + sigma*X(t)dW(t), t > 0,
% with X(0) = X0:
mu = 1;       % drift term, is often an interest rate
sigma = 0.2;  % noise term
X0 = 1;       % initial data

%% Now we will produce npath *exact* (analytical) sample outcomes of the GBM

% first, we define a suitable time discretization
dt = 0.1;
%Tend = 5;
Tend=5;
tspan = 0:dt:Tend;

% next, there is an exact closed form solution which requires a Wiener
% process, so sample a Wiener process first:
npath=30;
clear X
for k=1:npath
  W = randn(1,numel(tspan)-1)*sqrt(dt);
  W = cumsum([0 W]);  % the Wiener process starts at W(t = 0) = 0

  % closed form solution - see the Wikipedia article
  X(k,:) = X0*exp((mu-sigma^2/2)*tspan+sigma*W);
end
% Plotting
figure(1), clf,
h0 = plot(tspan,X,'b');
hold on

%% Her we produce *exact* (analytical) mean and variances
Xmean = X0*exp(mu*tspan);
Xvar = X0^2*exp(2*mu*tspan).*(exp(sigma^2*tspan)-1);

% plot in the form "mean +/- std"
h1 = plot(tspan,Xmean,'r', ...
     tspan,Xmean+sqrt(Xvar),'r:', ...
     tspan,Xmean-sqrt(Xvar),'r:');
set(h1,'LineWidth',2)

%% Finally we produce an *approximate* sample by an Euler discretization
Xapprox = zeros(size(tspan));
Xapprox(1) = X0;
for i = 1:numel(Xapprox)-1
  Xapprox(i+1) = Xapprox(i)+dt*mu*Xapprox(i)+ ...
      sqrt(dt)*randn*sigma*Xapprox(i);
end

h2 = plot(tspan,Xapprox,'k--');
set(h2,'LineWidth',2)
legend([h0(1); h1(1); h2], ...
       'Sample exact path','Expected value (exact)','Euler sample path');
xlabel('Time t');
txt = ['Geometric Brownian Motion, exact and Euler solutions. \sigma=',num2str(sigma),' \mu=',num2str(mu)];
title(txt);
hold off