% Create some variables
spike_times = spike_times;
pos = megarat{1, 6}.videodata(:,1:2);
% Save the variable x,y,z into one *.mat file
save session6.mat spike_times pos pos_times
pos_times(1,1)=0;
for i=1:length(pos)-1
    pos_times(i+1,1)=i/39.0625;
end