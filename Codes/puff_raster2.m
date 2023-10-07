function [spike_times] = puff_raster2(spikes, events, secbefore, secafter, color)
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
num_events = length(events);
hold on
spike_times = [];
for ev_num = 1:num_events
	%find the spikes within a time window around each event
	tempspikes = event_spikes(spikes, events(ev_num),secbefore, secafter)

    %find the offset (in secs) from the current event
	found = 0;
	if (tempspikes > 0)
		found = 1;
		tempspikes = tempspikes - events(ev_num);
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

 xlim([secbefore*-1 secafter]);
 ylim([0 num_events+1]);

hold off

load("cell_megarat.mat");
spikes=cell_megarat{1,7}.spikes{1,1};
events=cell_megarat{1,7}.LtoRlaps(:,1); 
secbefore=5;
secafter=15;
color='blue';
pe_raster2(spikes, events, secbefore, secafter, color)