function myfig=pethra(unit,events, secbefore, secafter, nbins)
%function pethra(unit,events, secbefore, secafter, nbins)
%plots multiple perievent time histograms with rasters
%unit=stucture variable that must have a field 'ts',
%  which is an array of spike timestamps
%events=array of timestamps for a single behavioral event
%secbefore, secafter determine time window in seconds
%nbins=number of bins for the histogram
%calls both pe_th.m and pe_raster.m (which both call event_spikes.m)
%JRM 5-27-05

%To Do:
%-label x axis if no other graph below

%determine layout of subplots
num_units = length(unit);
fig_cols = floor(sqrt(num_units));
fig_rows = ceil(num_units/fig_cols);

subplotwidth = .9/fig_cols;%same for hist and rast
subplotheight = .9/fig_rows;
rast_height = subplotheight*.65;
hist_height = subplotheight*.35;


myfig = figure;%make sure we create a new figure to paint into
% plot the subplots
for u = 1:num_units
	%first determine layout position for current figure
	gridx = mod(u,fig_cols);
	if (gridx == 0)
		gridx = fig_cols;
	end
	gridy = ceil(u/fig_cols);
	leftmargin = .05;
	topmargin = .01;
	%then determine the actual coords
	leftside = leftmargin + ((gridx-1)*subplotwidth) + (gridx-1)*(.05/fig_cols);
	hist_bottom = 1 - topmargin - gridy*subplotheight - (gridy-1)*(.05/fig_rows);
	rast_bottom = hist_bottom + hist_height;
	
	%%%%%%%%%%%%%%%%%%%
	%%plot the raster%%
	%%%%%%%%%%%%%%%%%%%
	rast_ax(u) = subplot('Position', [leftside rast_bottom subplotwidth rast_height]);
	pe_raster(unit(u).ts,events,secbefore,secafter);
	set(gca,'XTickLabel',[]);%don't print numbers on the raster x-axis
	set(gca,'YTickLabel',[]);%don't print numbers on the raster y-axis
	set(gca,'Xcolor',[1 1 1]);%make the x tics white (not visible)
	%put the unit number on the graph
	unitnumtx = sprintf('%d',u);
	text(-secbefore+(secbefore+secafter)/(nbins*2),length(events)*.9,unitnumtx,'Color', [0 1 0]);%in green
	
	%%%%%%%%%%%%%%%%%%
	%%plot histogram%%
	%%%%%%%%%%%%%%%%%%
  hist_ax(u) = subplot('Position', [leftside hist_bottom subplotwidth hist_height]);
  pe_th(unit(u).ts,events,secbefore,secafter,nbins);
  if (gridy == fig_rows)
		xlabel('Time (seconds)');
	else
		set(gca,'XTickLabel',[]);%don't print second unless it's the bottom row
	end
	if (gridx == 1)
		ylabel('Hz');
	else
		set(gca,'YTickLabel',[]);%don't print Hz unless it's the left column
	end
	
end %end of main for loop

%make all the histograms have the same Y scale
for u = 1:num_units%first find largest y max
	yrange(u,1:2) = get(hist_ax(u), 'ylim');
end	
linkaxes(hist_ax,'y');%this way, changing one will change them all
set(hist_ax(1),'ylim',[0 max(yrange(:,2))]);

%legend([inputname(2)]);

end %end of function