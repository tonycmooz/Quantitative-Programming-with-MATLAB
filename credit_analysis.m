%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  MATLAB Sample Script written by Tony Moozhayil  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%   Sources used: MATLAB Financial Toolbox   %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Credit Risk Analysis %%%

% MATLAB has built in statistical machine learning 
% capabilities. Here we take advantage of a classification 
% algorithm known as a bagged decision tree.

% We will use this feature to build an automated credit 
% rating tool.

% Credit ratings are a small number of discrete classes, 
% usually labeled with letters, such as 'AAA','BB-', etc. 
% Credit scores are numeric grades such as '640' or '720'. 
% Credit grades are one of the key elements in regulatory 
% frameworks, such as Basel II (see Basel Committee on
% Banking Supervision [3]). 

creditDS = readtable('CreditRating_Historical.dat');

X = [creditDS.WC_TA creditDS.RE_TA creditDS.EBIT_TA creditDS.MVE_BVTD...
creditDS.S_TA creditDS.Industry];
Y = ordinal(creditDS.Rating);

leaf = [1 5 10];
nTrees = 25;
rng(9876,'twister');
savedRng = rng; % save the current RNG settings
color = 'bgr';
for ii = 1:length(leaf) 
    % Reinitializing the random number generator, so that the
    % random samples are the same for each leaf size
    rng(savedRng);
    % Create a bagged decision tree for each leaf size and plot out-of-bag
    % error 'oobError'
    b = TreeBagger(nTrees,X,Y,'OOBPred','on',...
                              'CategoricalPredictors',6,...
                              'MinLeaf',leaf(ii));
    plot(b.oobError,color(ii));
    hold on;
end
xlabel('Number of grown trees');
ylabel('Out-of-bag classification error');
legend({'1', '5', '10'},'Location','NorthEast');
title('Classification Error for Different Leaf Sizes');
hold off;
