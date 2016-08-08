%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  MATLAB Sample Script written by Tony Moozhayil  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%   Sources used: MATLAB Financial Toolbox   %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The settlement date of a bond is the date when money 
% first changes hands; that is, when a buyer pays for a bond. 
% It need not coincide with the issue date, which is the date 
% a bond is first offered for sale

% The first coupon date and last coupon date are the dates 
% when the first and last coupons are paid, respectively. 
% Although bonds typically pay periodic annual or semiannual
% coupons, the length of the first and last coupon periods 
% may differ from the standard coupon period

% Successive quasi-coupon dates determine the length of the 
% standard coupon period for the fixed income security of 
% interest, and do not necessarily coincide with actual 
% coupon payment dates. The toolbox includes functions that 
% calculate both actual and quasicoupon dates for bonds with 
% odd first and/or last periods.

% Fixed-income securities can be purchased on dates that do 
% bond owner is not entitled to the full value of the
% coupon for that period. When a bond is purchased between
% coupon dates, the buyer must compensate the seller for the 
% pro-rata share of the coupon interest earned from the 
% previous coupon payment date. This pro-rata share of the 
% coupon payment is called accrued interest. The purchase 
% price, the price paid for a bond, is the quoted market 
% price plus accrued interest.

% The maturity date of a bond is the date when the issuer 
% returns the final face value, also known as the redemption 
% value or par value, to the buyer. The yield-to-maturity of 
% a bond is the nominal compound rate of return that equates 
% the present value of all future cash flows (coupons and 
% principal) to the current market price of the bond.

% The period of a bond refers to the frequency with 
% which the issuer of a bond makes coupon payments to 
% the holder.

% Period of a Bond
% Period Value Payment Schedule
%   0 No coupons (Zero coupon bond)
%   1 Annual
%   2 Semiannual
%   3 Tri-annual
%   4 Quarterly
%   6 Bi-monthly
%   12 Monthly

% The basis of a bond refers to the basis or day-count 
% convention for a bond. Basis is normally expressed as a 
% fraction in which the numerator determines the number of days
% between two dates, and the denominator determines the number 
% of days in the year. For example, the numerator of 
% actual/actual means that when determining the number of days 
% between two dates, count the actual number of days; the 
% denominator means that you use the actual number of days in 
% the given year in any calculations (either 365 or 366 days 
% depending on whether the given year is a leap year).


%%% Common Input Arguments %%%

%    Input                   Meaning
%   Settle              Settlement date
%   Maturity            Maturity date
%   Period              Coupon payment period
%   Basis               Day-count basis
%   EndMonthRule        End-of-month payment rule
%   IssueDate           Bond issue date
%   FirstCouponDate     First coupon payment date
%   LastCouponDate      Last coupon payment date


% Single Bond Example

Settle = '20-Sep-1999'
Maturity = '15-Oct-2007'
Period = 2
Basis = 0
EndMonthRule = 1
IssueDate = NaN
FirstCouponDate = NaN
LastCouponDate = NaN

% NaN stands for Not-a-Number
% It is a convenient placeholder
% In this software, NaN indicates 
% the presence of a nonapplicable value
% So it tells the Financial Toolbox functions 
% to ignore the input value and apply the default.

% Below all cfdates produce the same results

cfdates(Settle, Maturity)
cfdates(Settle, Maturity, Period)
cfdates(Settle, Maturity, Period, [])
cfdates(Settle, Maturity, [], Basis)
cfdates(Settle, Maturity, [], [])
cfdates(Settle, Maturity, Period, [], EndMonthRule)
cfdates(Settle, Maturity, Period, [], NaN)
cfdates(Settle, Maturity, Period, [], [], IssueDate)
cfdates(Settle, Maturity, Period, [], [], IssueDate, [], [])
cfdates(Settle, Maturity, Period, [], [], [], [],LastCouponDate)
cfdates(Settle, Maturity, Period, Basis, EndMonthRule, ...
IssueDate, FirstCouponDate, LastCouponDate)

% This unspecified input NaN has the same effect 
% as passing an empty matrix like ([])

% Bond Portfolio Example (Two Bonds)

Settle = '20-Sep-1999'
Maturity = ['15-Oct-2007'; '15-Oct-2010']

% Below are Default values (Period = 2)

cfdates(Settle, Maturity, 2)
cfdates(Settle, Maturity, [2 2])
cfdates(Settle, Maturity, [])
cfdates(Settle, Maturity, NaN)
cfdates(Settle, Maturity, [NaN NaN])
cfdates(Settle, Maturity)


% Here the first call explicitly sets Period = 4 for the first 
% bond and implicitly sets the default Period = 2 for the second 
% bond. The second call has the same effect as the first but
% explicitly sets the periodicity for both bonds.

cfdates(Settle, Maturity, [4 NaN])
cfdates(Settle, Maturity, [4 2])

% Pricing Functions

Settle = '11-Nov-1992';
Maturity = '01-Mar-2005';
IssueDate = '15-Oct-1992';
FirstCouponDate = '01-Mar-1993';
CouponRate = 0.0785;
Yield = 0.0625;

[Price, AccruedInt] = bndprice(Yield, CouponRate, Settle, ...
Maturity, [], [], [], IssueDate, FirstCouponDate)


% Yield Functions

Settle              = '12-Jan-2000';
Maturity            = '01-Oct-2001';
IssueDate           = '01-Jan-2000';
FirstCouponDate     = '15-Jan-2000';
LastCouponDate      = '15-Apr-2000';

% Assume a face value of $100. Specify a purchase price of 
% $96.30, a coupon rate of 4.2%, quarterly coupon payments, 
% and a 30/360 day-count convention (Basis = 1).

Price        = 96.3;
CouponRate   = 0.042;
Period       = 4;
Basis        = 1;
EndMonthRule = 1;

Yield = bndyield(Price, CouponRate, Settle, Maturity, Period,...
Basis, EndMonthRule, IssueDate, FirstCouponDate, LastCouponDate)

%%% Fixed-Income Sensitivities %%%

% bnddurp and bnddury support duration and convexity analysis 
% based on market quotes and assume parallel shifts in the 
% bond yield curve.

% bndkrdur supports key rate duration based on a market yield 
% curve and can model nonparallel shifts in the bond yield curve.


% The Macaulay duration of an income stream, such as a coupon bond, 
% measures how long, on average, the ownerwaits before receiving 
% a payment. It is the weighted average of the times payments are 
% made, with the weights at time T equal to the present value of the 
% money received at time T. The modified duration is the Macaulay 
% duration discounted by the per-period interest rate; that is, 
% divided by (1+rate/frequency).

CouponRate = 0.05;
Yield = 0.045;

[ModDuration, YearDuration, PerDuration] = bnddury(Yield,...
CouponRate, Settle, Maturity)


% Calculating Key Rate Durations for Bonds

% PV is the current value of the instrument, PV_up and PV_down are the new
% values after the discount curve has been shocked, and ShiftValue is the 
% change in interest rate. For example, if key rates of 3 months, 1, 2, 3, 
% 5, 7, 10, 15, 20, 25, 30 years were chosen, then a 30-year bond might 
% have corresponding key rate durations of:

% 3M   1Y  2Y  3Y  5Y 7Y 10Y  15Y  20Y  25Y  30Y
% .01 .04 .09 .21 .4 .65 1.27 1.71 1.68 1.83 7.03

% The key rate durations add up to approximately equal the duration of the 
% bond. For example, compute the key rate duration of the U.S. Treasury 
% Bond with maturity date of August 15, 2028 and coupon rate of 5.5%.

Settle = datenum('18-Nov-2008');
CouponRate = 5.500/100;
Maturity = datenum('15-Aug-2028');
Price = 114.83;

ZeroDates = daysadd(Settle ,[30 90 180 360 360*2 360*3 360*5 ...
360*7 360*10 360*20 360*30]);
ZeroRates = ([0.06 0.12 0.81 1.08 1.22 1.53 2.32 2.92 3.68 4.42 4.20]/100)';

krd = bndkrdur([ZeroDates ZeroRates],CouponRate,Settle,Maturity,'keyrates',[2 5 10 20])

[sum(krd) bnddurp(Price,CouponRate,Settle,Maturity)]

%%% Treasury Bills %%%

% Treasury bills are short-term securities (issued with maturities of 
% 1 year or less) sold by the United States Treasury. Sales of these 
% securities are frequent, usually weekly. From time to time, the 
% Treasury also offers longer duration securities called Treasury notes
% and Treasury bonds.

% A Treasury bill is a discount security. The holder of the Treasury 
% bill does not receive periodic interest payments. Instead, at the 
% time of sale, a percentage discount is applied to the face value. 
% At maturity, the holder redeems the bill for full face value.

% The basis for Treasury bill interest calculation is actual/360. 
% Under this system, interest accrues on the actual number of elapsed
% days between purchase and maturity, and each
% year contains 360 days.

% Computing Treasury Bill Price and Yield

%   Function            Purpose
% tbilldisc2yield     Convert discount rate to yield.
% tbillprice          Price Treasury bill given its yield or discount rate.
% tbillrepo           Break-even discount of repurchase agreement.
% tbillyield          Yield and discount of Treasury bill given its price.
% tbillyield2disc     Convert yield to discount rate.
% tbillval01          The value of 1 basis point given the characteristics 
%                     of the Treasury bill, as represented by its settlement
%                     and maturity dates. You can relate the basis point 
%                     to discount, money-market, or bond-equivalent yield.


% Treasury Bill Repurchase Agreements (REPOs)

% The following example shows how to compute the break-even discount rate.
% This is the rate that correctly prices the Treasury bill such that 
% the profit from selling the tail equals 0.

Maturity = '26-Dec-2002';
InitialDiscount = 0.0161;
PurchaseDate = '26-Sep-2002';
SaleDate = '26-Oct-2002';
RepoRate = 0.0149;
BreakevenDiscount = tbillrepo(RepoRate, InitialDiscount, ...
PurchaseDate, SaleDate, Maturity)

% One can check the result of this computation by examining the cash 
% flows in and out from the repurchase transaction. First compute the 
% price of the Treasury bill on the purchase date (September 26).

PriceOnPurchaseDate = tbillprice(InitialDiscount, ...
PurchaseDate, Maturity, 3)

% And next compute the interest due on the repurchase agreement.

RepoInterest = ...
RepoRate*PriceOnPurchaseDate*days360(PurchaseDate,SaleDate)/360

% We find out the RepoInterest for a 1.49% 30-day term 
% repurchase agreement (30/360 basis) is 0.1237.

% Finally, we compute the price of the Treasury bill on the 
% sale date (October 26).

PriceOnSaleDate = tbillprice(BreakevenDiscount, SaleDate, ...
Maturity, 3)

% Treasury Bill Yields
% An example with a useful function tbilldisc2yield that can 
% perform both computations at one time

Maturity = '26-Dec-2002';
InitialDiscount = 0.0161;
PurchaseDate = '26-Sep-2002';
SaleDate = '26-Oct-2002';
RepoRate = 0.0149;
BreakevenDiscount = tbillrepo(RepoRate, InitialDiscount, ...
PurchaseDate, SaleDate, Maturity)
[BEYield, MMYield] = ...
tbilldisc2yield([InitialDiscount; BreakevenDiscount], ...
[PurchaseDate; SaleDate], Maturity)
