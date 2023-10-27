% Load data
%load 'Data for plot.mat'
data = puffdata2;

% Number of data sets, variables, and values
nDataSets = 5;
nVars = 4;
nVals = 1000;

% Create column vector to indicate dataset
dataSet = categorical([ones(nVars*nVals,1); ...
    ones(nVars*nVals,1)*2; ...
    ones(nVars*nVals,1)*3; ...
    ones(nVars*nVals,1)*4;...
    ones(nVars*nVals,1)*5]);

% Create column vector to indicate the variable
clear var
var(1:nVals,1) = "Var1";
var(end+1:end+nVals,1) = "Var2";
var(end+1:end+nVals,1) = "Var3";
var(end+1:end+nVals,1) = "Var4";

Var = categorical([var;var;var;var;var]);

% Create a table
testData = table(data,dataSet,Var);

% Perform t-tests and store p-values in a table
groups = unique(testData.Var);
pValues = nan(length(groups));
for i = 1:length(groups)
    for j = i+1:length(groups)
        group1 = testData.data(testData.Var == groups(i));
        group2 = testData.data(testData.Var == groups(j));
        [~, p] = ttest2(group1, group2); % Perform t-test
        pValues(i, j) = p;
    end
end

% Adjust p-values for multiple comparisons (Bonferroni correction)
alpha = 0.05; % Adjust this as needed
adjustedPValues = pValues * numel(pValues);
significantPairs = find(adjustedPValues < alpha);

% Create boxplot with significant pairs highlighted
h = boxplot(testData.data, {testData.dataSet, testData.Var}, ...
    'ColorGroup', testData.Var, ...
    'Labels', {'','BLA','','','','CEN','','','','HPC','','','','PIR','','','','ALL','','',});

% Don't display outliers
ol = findobj(h,'Tag','Outliers');
set(ol,'Visible','off');

% Find all boxes
box_vars = findall(h,'Tag','Box');

% Fill boxes
for j = 1:length(box_vars)
    patch(get(box_vars(j),'XData'), get(box_vars(j),'YData'), box_vars(j).Color, 'FaceAlpha', 1, 'EdgeColor', 'none');
end

% Add legend
Lg = legend(box_vars(1:4), {'LDA True Accuracy', 'LDA Shuffled Accuracy', 'NB True Accuracy', 'NB Shuffled Accuracy','mean'}, 'Location', 'northoutside', 'Orientation', 'horizontal');

% Add Mean to boxplots  
summaryTbl = groupsummary(testData, {'dataSet','Var'}, "mean");
hold on
plot(summaryTbl.mean_data, '+k')
hold off

% Highlight significant pairs with asterisks
for i = 1:length(significantPairs)
    [row, col] = ind2sub(size(pValues), significantPairs(i));
    x = col;
    y = max(testData.data);
    text(x, y + 0.1, '*', 'FontSize', 12, 'HorizontalAlignment', 'center');
end