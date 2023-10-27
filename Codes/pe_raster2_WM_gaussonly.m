function [spike_times] = pe_raster2_WM(spikes, secbefore, secafter, color, stimids)
%function pe_raster(spikes, events, secbefore, secafter,color)
%plots a perievent raster
%spikes=array of timestamps for a single unit
%events=array of timestamps for a single behavioral event
%secbefore=time (in seconds) before event
%secafter=time (in seconds) after event
%color can be a string (e.g., 'b') or a rgb triplet (e.g., [0 0 1])
%spikes_times = column of spikes times relative to events
%**calls event_spikes.m
%JRM
num_events = length(spikes);
hold on
spike_times = [];

ev1=find(stimids ==1 );
ev2=find(stimids == 2);
ev3=find(stimids == 3);
ev4=find(stimids == 4);
order=[ev1; ev2; ev3; ev4];

for ev_num = 1:num_events
    trial=ev_num;
    if stimids(trial) == 1
        color= 'k';
    elseif stimids(trial) == 2
        color= 'k';
    elseif stimids(trial) == 3
        color= 'k';
    elseif stimids(trial) == 4
        color= 'k';
    end
    spikesc=spikes(trial,1);
    spikesev=spikesc{1,1};
	%find the spikes within a time window around each event
	tempspikes = spikesev(spikesev>=0 & spikesev<secafter);

    %find the offset (in secs) from the current event
	found = 0;
	if (tempspikes > 0)
		found = 1;
		tempspikes = tempspikes- 0;
        spike_times = [spike_times; tempspikes];
        
		lineheight = [zeros(1,length(tempspikes)); .95*ones(1,length(tempspikes))]+ ev_num;
        %lineheight is two rows, the first row is a vector of zeros the
        %length of tempspikes. The second row is just 0.95 more of the
        %first row.
        
        linehandle = line([tempspikes'; tempspikes'], lineheight, 'Linewidth', 1.2);
        %linehandle generates a line image that must have the same
        %dimensions as lineheight. Therefore, we have transposed tempspikes
        %to become a row vector.
        
		set(linehandle, 'color', color);
		end%end of if found
end%end of for loop

 %xlim([0 secafter]);
 xlim([0 3000]);
 ylim([0 num_events+1]);

hold off