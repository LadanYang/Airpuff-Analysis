function [spike_times] = pe_raster(spikes, events, secbefore, secafter)
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
	tempspikes = event_spikes(spikes, events(ev_num),secbefore, secafter);

    %find the offset (in secs) from the current event
	found = 0;
	if (tempspikes > 0)
		found = 1;
		tempspikes = tempspikes - events(ev_num);
        % put in cell cause some trials have more spiketimes
        spike_times{ev_num} = tempspikes'; %bug fix ' transposition of tempspikes
        
		lineheight = [zeros(1,length(tempspikes)); .95*ones(1,length(tempspikes))]+ ev_num;
        %lineheight is two rows, the first row is a vector of zeros the
        %length of tempspikes. The second row is just 0.95 more of the
        %first row.
        
        linehandle = line([tempspikes'; tempspikes'], lineheight); %bug fix add ' to both tempspikes
        %linehandle generates a line image that must have the same
        %dimensions as lineheight. Therefore, we have transposed tempspikes
        %to become a row vector.
        
        set(linehandle, 'color', 'b');
       
		end%end of if found
end%end of for loop

 xlim([secbefore*-1 secafter]);
 ylim([0 num_events+1]);

hold off