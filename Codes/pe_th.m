function [allfoundspikes] = pe_th(spikes, events, secbefore, secafter, nbins)
%function pe_th(spikes, events, secbefore, secafter,nbins)
%plots a perievent time histogram
%spikes=array of timestamps for a single unit
%events=array of timestamps for a single behavioral event
%secbefore=time (in seconds) before event (positive number)
%secafter=time (in seconds) after event (positive number)
%**calls event_spikes.m
%JRM 5-27-05


%to do
%-plot error bars

tot_duration = secbefore + secafter;
bin_duration = tot_duration/nbins;

num_events = length(events);
allfoundspikes = [];

hold on

for ev_num = 1:num_events
	%find the spikes within a time window around each event
	tempspikes = event_spikes(spikes, events(ev_num),secbefore, secafter);
	 
	found = 0;
	if (tempspikes > 0)
		found = 1;
		%find the offset (in secs) from the current event
		tempspikes = tempspikes - events(ev_num);
        tempspikes = tempspikes(:);
		%add those spikes to our accumulating total
		allfoundspikes = [allfoundspikes; tempspikes];
	end%end of if found
	
end%end of for loop

%determine the midpoint values for the histogram bins
for b = 1:nbins
	bin_times(b) = (-1*secbefore) +(.5*bin_duration) + (b-1)*bin_duration;
end

%get the counts per bin, but don't plot yet
[spikes_per_bin, xtimes] = hist(allfoundspikes,bin_times);
%convert spikes per bin to hertz
rate_per_bin = (spikes_per_bin ./ bin_duration) / num_events;

%plot it
bar(xtimes,rate_per_bin,1);
xlim([secbefore*-1 secafter]);%make sure the x scale is what we expect
ymax=1.2*max(rate_per_bin);
ylim([0 50]);

hold off
