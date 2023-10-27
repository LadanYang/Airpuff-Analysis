%load 'Data for plot.mat'

data=bindata2;
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

h = boxplot(testData.data,{testData.dataSet,testData.Var},...
    'ColorGroup',testData.Var,...
    'Labels',{'BLA-LDA','Shuffled','BLA_NB','Shuffled','CEN_LDA','Shuffled','CEN_NB','Shuffled','HPC_LDA','Shuffled','HPC_NB','Shuffled','PIR_LDA','Shuffled','PIR_NB','Shuffled','ALL_LDA','Shuffled','ALL_NB','Shuffled',});
 %set(gca,'XTickLabel',{' '})

% Don't display outliers
ol = findobj(h,'Tag','Outliers');
set(ol,'Visible','off');

% Find all boxes
box_vars = findall(h,'Tag','Box');

% Fill boxes
for j=1:length(box_vars)
    patch(get(box_vars(j),'XData'),get(box_vars(j),'YData'),box_vars(j).Color,'FaceAlpha',0.8,'EdgeColor','none');
end


%% Add Mean to boxplots  
summaryTbl = groupsummary(testData,{'dataSet','Var'},"mean")
hold on
plot(summaryTbl.mean_data, '+k')
hold off


sigstar({[1,2],[3,4],[5,6],[7,8],[9,10],[11,12],[13,14],[15,16],[17,18],[19,20]},p_bin)

xticks(1:4:20); % Adjust the positions as needed
xticklabels({'BLA', 'CEN', 'HPC', 'PIR', 'ALL'}); % Replace with your desired names

% Add legend
Lg = legend(box_vars(1:4), {'LDA True Accuracy','LDA Shuffled Accuracy', 'NB True Accuracy','NB Shuffled Accuracy'},'Location','northoutside','Orientation','horizontal');
Lg.String{5} = 'mean';