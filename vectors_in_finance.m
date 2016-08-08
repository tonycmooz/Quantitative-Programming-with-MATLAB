%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  MATLAB Sample Script written by Tony Moozhayil  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%   Sources used: MATLAB Financial Toolbox   %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Multiplying Vectors

ClosePrices = [42.5 15 78.875]

NumShares = [100
             500
             300]
         
PortfValue = ClosePrices * NumShares

ValuesOfEachStock = NumShares * ClosePrices

% Computing Dot Products of Vectors';

DotProductVectorComputation = sum(NumShares .* ClosePrices')


% Multiplying Vectors and Matrices with
% Week Closing Prices and stock quantities in Portfolio

WeekClosePr = [42.5 15 78.875
               42.125 15.5 78.75
               42.125 15.125 79
               42.625 15.25 78.875
               43 15.25 78.625];
           
           % 5 by 3 Matrix
WeekClosePr

PortQuan = [100
            500
            300];
        
           % 3 by 1 Matrix
PortQuan

WeekPortValue = WeekClosePr * PortQuan

           % 5 by 1 Matrix

% Multiplying Two Matrices

Portfolios = [100 200
              500 400
              300 150];

           % 3 by 2 Matrix
Portfolios

PortfolioValues = WeekClosePr * Portfolios
           % 5 by 2 Matrix
           
% Multiplying and Dividing a Matrix by a Scalar

DoublePort = Portfolios * 2

HalfPort = Portfolios / 2
