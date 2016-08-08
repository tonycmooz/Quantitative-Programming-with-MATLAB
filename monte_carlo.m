% Monte Carlo Simulation

% A mathematical modeling process. For a model that
% has several parameters with statistical properties, 
% pick a set of random values for the parameters and 
% run a simulation. Then pick another set of values, 
% and run it again. Run it many times (often 10,000 
% times) and build up a statistical distribution of 
% outcomes of the simulation. This distribution of 
% outcomes is then used to answer whatever question 
% you are asking.

% Pricing American Basket Options by Monte Carlo Simulation

% This example shows how to model the fat-tailed behavior 
% of asset returns and assess the impact of alternative joint 
% distributions on basket option prices. Using various 
% implementations of a separable multivariate Geometric Brownian 
% Motion (GBM) process,often referred to as a multi-dimensional 
% market model, the example simulates riskneutral sample paths 
% of an equity index portfolio and prices basket put options 
% using the technique of Longstaff & Schwartz.

clear
load Data_GlobalIdx2

nIndices = size(Data,2)-1; % # of indices
prices = Data(:,1:end-1);
yields = Data(:,end); % daily effective yields
yields = 360 * log(1 + yields); % continuously-compounded, annualized yield
plot(dates, ret2tick(tick2ret(prices,[],'continuous'),[],[],[],'continuous'))
datetick('x')

xlabel('Date')
ylabel('Index Value')
title ('Normalized Daily Index Closings')
legend(series{1:end-1}, 'Location', 'NorthWest')

plot(dates, 100 * yields)
datetick('x')
xlabel('Date')
ylabel('Annualized Yield (%)')
title('Risk Free Rate (3-Month Euribor Continuously-Compounded)')

tailFraction = 0.1; % decimal fraction allocated to each tail
tails = cell(nIndices,1); % cell array of Pareto tail objects
for i = 1:nIndices
tails{i} = paretotails(returns(:,i), tailFraction, 1 - tailFraction, 'kernel');
end
