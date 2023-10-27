
n_neurons = root.spk_ts(root.cells);


for i = 1:length(n_neurons)
    figure;
%condition 1    
    subplot(2,2,3);
    hFig = subplot(2,2,3);
    set(hFig, 'Position', [0.2 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,1);
    hFig = subplot(2,2,1);
    set(hFig, 'Position', [0.2 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 1, Pos1, Item A');
%condition 2
    subplot(2,2,4);
    hFig = subplot(2,2,4);
    set(hFig, 'Position', [0.5 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo2, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,2);
    hFig = subplot(2,2,2);
    set(hFig, 'Position', [0.5 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo2, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 2, Pos3, Item A');

end


n_neurons = root.spk_ts(root.cells);


for i = 1:length(n_neurons)
    figure;
%condition 3    
    subplot(2,2,3);
    hFig = subplot(2,2,3);
    set(hFig, 'Position', [0.2 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo3, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,1);
    hFig = subplot(2,2,1);
    set(hFig, 'Position', [0.2 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo3, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 1, Pos1, Item C');
%condition 4
    subplot(2,2,4);
    hFig = subplot(2,2,4);
    set(hFig, 'Position', [0.5 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo4, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,2);
    hFig = subplot(2,2,2);
    set(hFig, 'Position', [0.5 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo4, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 2, Pos3, Item C');
    
end


n_neurons = root.spk_ts(root.cells);


for i = 1:length(n_neurons)
    figure;
%condition 5    
    subplot(2,2,3);
    hFig = subplot(2,2,3);
    set(hFig, 'Position', [0.2 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo5, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,1);
    hFig = subplot(2,2,1);
    set(hFig, 'Position', [0.2 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo5, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 1, Pos1, Item B');
%condition 6
    subplot(2,2,4);
    hFig = subplot(2,2,4);
    set(hFig, 'Position', [0.5 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo6, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,2);
    hFig = subplot(2,2,2);
    set(hFig, 'Position', [0.5 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo6, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 2, Pos3, Item B');
    
end

n_neurons = root.spk_ts(root.cells);


for i = 1:length(n_neurons)
    figure;
%condition 7    
    subplot(2,2,3);
    hFig = subplot(2,2,3);
    set(hFig, 'Position', [0.2 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo7, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,1);
    hFig = subplot(2,2,1);
    set(hFig, 'Position', [0.2 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo7, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 1, Pos1, Item D');
%condition 8
    subplot(2,2,4);
    hFig = subplot(2,2,4);
    set(hFig, 'Position', [0.5 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo8, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,2);
    hFig = subplot(2,2,2);
    set(hFig, 'Position', [0.5 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo8, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 2, Pos3, Item D');
    
end


n_neurons = root.spk_ts(root.cells);


for i = 1:length(n_neurons)
    figure;
%condition 9    
    subplot(2,2,3);
    hFig = subplot(2,2,3);
    set(hFig, 'Position', [0.2 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo9, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,1);
    hFig = subplot(2,2,1);
    set(hFig, 'Position', [0.2 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo9, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 1, Pos2, Item A');
%condition 10
    subplot(2,2,4);
    hFig = subplot(2,2,4);
    set(hFig, 'Position', [0.5 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo10, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,2);
    hFig = subplot(2,2,2);
    set(hFig, 'Position', [0.5 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo10, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 2, Pos4, Item A');

end


n_neurons = root.spk_ts(root.cells);


for i = 1:length(n_neurons)
    figure;
%condition 11    
    subplot(2,2,3);
    hFig = subplot(2,2,3);
    set(hFig, 'Position', [0.2 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo11, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,1);
    hFig = subplot(2,2,1);
    set(hFig, 'Position', [0.2 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo11, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 1, Pos2, Item C');
%condition 12
    subplot(2,2,4);
    hFig = subplot(2,2,4);
    set(hFig, 'Position', [0.5 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo12, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,2);
    hFig = subplot(2,2,2);
    set(hFig, 'Position', [0.5 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo12, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 2, Pos4, Item C');
    
end


n_neurons = root.spk_ts(root.cells);


for i = 1:length(n_neurons)
    figure;
%condition 13    
    subplot(2,2,3);
    hFig = subplot(2,2,3);
    set(hFig, 'Position', [0.2 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo13, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,1);
    hFig = subplot(2,2,1);
    set(hFig, 'Position', [0.2 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo13, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 1, Pos2, Item B');
%condition 14
    subplot(2,2,4);
    hFig = subplot(2,2,4);
    set(hFig, 'Position', [0.5 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo14, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,2);
    hFig = subplot(2,2,2);
    set(hFig, 'Position', [0.5 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo14, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 2, Pos4, Item B');
    
end

n_neurons = root.spk_ts(root.cells);


for i = 1:length(n_neurons)
    figure;
%condition 15    
    subplot(2,2,3);
    hFig = subplot(2,2,3);
    set(hFig, 'Position', [0.2 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo15, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,1);
    hFig = subplot(2,2,1);
    set(hFig, 'Position', [0.2 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo15, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 1, Pos2, Item D');
%condition 16
    subplot(2,2,4);
    hFig = subplot(2,2,4);
    set(hFig, 'Position', [0.5 0.05 0.25 0.4]);
    set(gca,'fontsize', 14);
    [allfoundspikes] = pe_th(n_neurons{1,i}, epo16, 0, 2, 20);
    allfoundspikes_all{i} = allfoundspikes;

    subplot(2,2,2);
    hFig = subplot(2,2,2);
    set(hFig, 'Position', [0.5 0.53 0.25 0.4]);
    set(gca,'fontsize', 14);
    [spike_times] = pe_raster2(n_neurons{1,i}, epo16, 0, 2, 'black');
    spike_times_all{i} = spike_times;
    title('Context 2, Pos4, Item D');
    
end

