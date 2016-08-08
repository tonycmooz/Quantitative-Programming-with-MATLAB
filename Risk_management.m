%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  MATLAB Sample Script written by Tony Moozhayil  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%   Sources used: MATLAB Financial Toolbox   %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Sharpe Ratio %%%

% Is a ratio of excess return of an asset divided by the assets 
% standard deviation of returns. The Sharpe ratio has the form:

%           (Mean - Riskless) / Sigma

% To compute the Sharpe ratio, the mean return of the cash asset 
% is used as the return for the riskless asset. Thus, given asset 
% return data and the riskless asset return, the Sharpe ratio is 
% calculated with. 

load FundMarketCash
Returns = tick2ret(TestData);
Riskless = mean(Returns(:,3))
Sharpe = sharpe(Returns, Riskless)

% The resulting calculated Sharpe ratio of the example fund 
% above is actually significantly higher than the Sharpe ratio 
% of the market.

% The Sharpe ratio was calculated with the mean of cash returns.
% The 0 inevitably makes sense since it translates into a strong-
% risk adjusted return. Cash is the same as Riskless asset**

%%% Risk-adjusted return %%%

% 
% Risk-adjusted return either shifts the risk (which is the 
% standard deviation of returns) of a portfolio to match the risk 
% of a market portfolio or shifts the risk of a market portfolio
% to match the risk of a fund. According to the Capital Asset 
% Pricing Model (CAPM), the market portfolio and a riskless asset
% are points on a Security Market Line (SML). The return of the
% resultant shifted portfolio, levered or unlevered, to match 
% the risk of the market portfolio, is the risk-adjusted return. 
% The SML provides another measure of risk-adjusted return, since 
% the difference in return between the fund and the SML, return at
% the same level of risk.

load FundMarketCash
Returns = tick2ret(TestData);
Fund = Returns(:,1);
Market = Returns(:,2);
Cash = Returns(:,3);
MeanFund = mean(Fund)
MeanMarket = mean(Market)

[MM, aMM] = portalpha(Fund, Market, Cash, 'MM')
[GH1, aGH1] = portalpha(Fund, Market, Cash, 'gh1')
[GH2, aGH2] = portalpha(Fund, Market, Cash, 'gh2')
[SML, aSML] = portalpha(Fund, Market, Cash, 'sml')

% Since the fund's risk is much less than the market's risk,
% the risk-adjusted return of the fund is much higher than 
% both the nominal fund and market returns.

%%% Maximum drawdown %%%

% We can also test the maximum drawdown or the max decline
% from a peak to trough (nadir)

load FundMarketCash
MaxDD = maxdrawdown(TestData)

% The results show 16.58% max drop for the fund 
% And 33.81% for the market

% Although the maximum drawdown is measured in terms of returns, 
% maxdrawdown can measure the drawdown in terms of absolute drop 
% in value, or in terms of log-returns. To contrast these 
% alternatives more clearly, we work with the fund series 
% assuming, an initial investment of $5 Million dollars:

Fund5000000 = 5000000*TestData(:,1);
plot(Fund5000000);
title('\bfFive-Year Fund Performance, Initial Investment $5,000,000 USD');
xlabel('Months');
ylabel('Value of Investment');

% Here, we again test for max drawdown

MaxDD5000000Ret = maxdrawdown(Fund5000000)

% Next, we compute the maximum drop in value, 
% using the arithmetic argument

[MaxDD5000000Arith, Ind5000000Arith] = maxdrawdown(Fund5000000,'arithmetic')


% We can also use the log-returns of the fund to compute 
% an expected maximum drawdown (EMaxDD)

load FundMarketCash
logReturns = log(TestData(2:end,:) ./ TestData(1:end - 1,:));
Mu = mean(logReturns(:,1));

Sigma = std(logReturns(:,1),1);
T = size(logReturns,1);

MaxDD = maxdrawdown(TestData(:,1),'geometric')
EMaxDD = emaxdrawdown(Mu-0.5*Sigma^2, Sigma, T)
