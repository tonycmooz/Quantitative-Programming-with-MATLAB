%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  MATLAB Sample Script written by Tony Moozhayil  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%   Sources used: MATLAB Financial Toolbox   %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Analyzing and Computing Cash Flows

Stream = [-20000, 2000, 2500, 3500, -5000, 6500,...
9500, 9500, 9500];

Stream

% Internal rate of return = irr
% Rate of Return

ROR = irr(Stream)
ROR*100

% Effective rate of return
% of nominal rates or Annual percentage rate, APR

Rate = effrr(0.09, 12)
Rate*100

% In this case, we look for the effective rate of a 
% 9% APR compounded monthly

% Present or Future Values
% Net Present Value

NPV = pvvar(Stream, ROR)

% Depreciation

% This example has a salvage value of $1500. The car
% depreciates over five years. I ran two different 
% rates of depreciation. 50% (or 1.5) and 100%(or 2.0)

Depreciation1 = depgendb(15000, 1500, 5, 1.5)
Depreciation1 = depgendb(15000, 1500, 5, 2.0)

% Annuities

% This example shows how to compute the interest rate 
% associated with a series of loan payments when only 
% the payment amounts and principal are known. For a 
% loan whose original value was $5000.00 and which was 
% paid back monthly over four years at $130.00/month:

InterestRate = annurate(4*12, 130, 5000, 0, 0)

% The next example uses a present-value function to 
% show how to compute the initial principal when the 
% payment and rate are known. For a loan paid at 
% $300.00/month over four years at 11% annual interest

Principal = pvfix(0.11/12, 4*12, 300, 0, 0)

disp(num2str(Principal,'%.2f'))

% The last example computes an amortization schedule 
% for a loan or annuity. The original value was $5000.00 
% and was paid back over 12 months at an annual rate of 9%.

[Prpmt, Intpmt, Balance, Payment] = ...
amortize(0.09/12, 12, 5000, 0, 0);

% The Prpmt function returns vectors containing the 
% amount of principal paid

Prpmt

% This is the amount of interest paid function
Intpmt

% The remaining balance for each period of the loan
Balance

% Monthly payment
Payment
