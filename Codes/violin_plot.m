% Sample data for the violin plot
data = {nb_bla_shuffled, bla_shuffled,nb_hpc_shuffled, nb_bla_airpuff};

% Create a violin plot
violin(data, 'xlabel', {'NB BLA Shuffled', 'LDA BLA Shuffled', 'NB HPC Shuffled','NB BLA Airpuff'});

% Customize the plot (optional)
title('Violin Plot Example');
ylabel('Data Values');


% Generate sample data for the violin plot
numGroups = 10;
numAttributes = 2;


% Create a violin plot
h = violin(vpuffdara, 'xlabel', {'BLA_LDA', 'BLA_NB', 'CEN_LDA', 'CEN_NB', 'HPC_LDA','HPC_NB','PIR_LDA','PIR_NB','ALL_LDA','ALL_NB'});

% Customize the plot (optional)
title('Violin Plot Example');
ylabel('Data Values');

% Set the colors for each attribute consistently across groups
colors = parula(numAttributes); % You can choose a different colormap
for attribute = 1:numAttributes
    set(h(attribute), 'FaceColor', colors(attribute, :));
end

% Add a legend to indicate attribute colors
legendCell = cellstr(num2str((1:numAttributes)', 'DATA'));
legend(legendCell, 'Location', 'NorthEast');

% Rotate x-axis labels for better visibility
xtickangle(45);




% Define the number of groups and attributes
numGroups = 10;
numAttributes = 2;

% Define the custom color palette (2 colors for 2 attributes)
% You can adjust these RGB values or add more colors as needed
custom_palette = [
    0 0 1; % Blue for 'Data'
    1 0 0; % Red for 'Shuffled'
    %0 0.5 0.5; % Another color for 'Data' in group 2, adjust as needed
    %0.5 0 0.5; % Another color for 'Shuffled' in group 2, adjust as needed
    % Add more colors as needed
];

% Create a violin plot with the custom color palette
% Replace 'data' with your actual data
figure;
violin(vpuffdara, 'ViolinColor', custom_palette);

% Customize the plot further as needed
title('Violin Plot for 10 Groups with 2 Attributes');
xlabel('Groups');
ylabel('Attribute Values');
xticklabels({'BLA_LDA', 'BLA_NB', 'CEN_LDA', 'CEN_NB', 'HPC_LDA','HPC_NB','PIR_LDA','PIR_NB','ALL_LDA','ALL_NB'});

% Add a legend to indicate the colors
legend({'Data', 'Shuffled'}, 'Location', 'Best');




% Example data with two attributes and 10 groups
data = rand(100, 10); % 100 data points for 10 groups

% Define the custom color palette for two attributes
custom_palette = [
    0 0 1; % Blue for 'Data'
    1 0 0; % Red for 'Shuffled'
];

% Create a violin plot with the custom color palette
figure;
vp = violin(data, 'ViolinColor', custom_palette);

% Define colors for the violin portions (e.g., distinct colors)
violin_colors = [
    0 0 1; % Blue for 'Data'
    1 0 0; % Red for 'Shuffled'
];

% Loop through the violins and set the EdgeColor property
for i = 1:numel(vp)
    vp(i).ViolinColor = violin_colors(i, :);
end


