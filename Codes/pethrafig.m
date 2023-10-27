function pethrafig(unit,events, secbefore, secafter, nbins,yrangeset)
%function pethra(unit,events, secbefore, secafter, nbins,yrangeset)
%plots multiple perievent time histograms with rasters
%unit=stucture variable that must have a field 'ts',
%  which is an array of spike timestamps
%events=array of timestamps for all behavioral events (bf) hardcoded 24 in
%secbefore, secafter determine time window in seconds
%nbins=number of bins for the histogram
%yrange sets the yrange for the histogram on the bottom
%calls both pe_th.m and pe_raster.m (which both call event_spikes.m)
%JRM 5-27-05
% JHB 6-13 made this for a single cell and only item sampling
% INPUT LOOKS LIKE pethrafig(unitTS{2},bf,.1,2,10)
%To Do:
%-label x axis if no other graph below
% This one is for the eight that are on chris's poster


%this puts the events in the right order to be plotted
usedevents.xrw=events.XRW;

usedevents.yrw=events.YRW;

usedevents.xle=events.XLE;

usedevents.yle=events.YLE;

usedevents.xlw=events.XLW;

usedevents.ylw=events.YLW;

usedevents.yre=events.YRE;

usedevents.xre=events.XRE;



%determine layout of subplots
fnames=fieldnames(usedevents);
num_events = length(fnames);
fig_rows = floor(sqrt(num_events));
fig_cols = ceil(num_events/fig_rows);

subplotwidth = .7/fig_cols;%same for hist and rast
subplotheight = .7/fig_rows;
rast_height = subplotheight*.65;
hist_height = subplotheight*.35;


myfig = figure;%make sure we create a new figure to paint into
% plot the subplots
for u = 1:num_events
    fn=fnames{u};
	%first determine layout position for current figure
	gridx = mod(u,fig_cols);
	if (gridx == 0)
		gridx = fig_cols;
	end
	gridy = ceil(u/fig_cols);
	leftmargin = .1;
	topmargin = .06;
	%then determine the actual coords
	leftside = leftmargin + ((gridx-1)*subplotwidth) + (gridx-1)*(.1/fig_cols);
	hist_bottom = 1 - topmargin - gridy*subplotheight - (gridy-1)*(.1/fig_rows);
	rast_bottom = hist_bottom + hist_height;
	
	%%%%%%%%%%%%%%%%%%%
	%%plot the raster%%
	%%%%%%%%%%%%%%%%%%%
	rast_ax(u) = subplot('Position', [leftside rast_bottom subplotwidth rast_height]);
	pe_raster_endsample(unit,usedevents.(fn),secbefore,secafter,1,1,[]);
	
    set(gca,'XTickLabel',[]);%don't print numbers on the raster x-axis
    
    
	%set(gca,'YTickLabel',[]); % dont print numbers on the raster y-axis
    
	set(gca,'Xcolor',[1 1 1]);%make the x tics white (not visible)
    
	%title(fn(u));
    %put the unit number on the graph
	
	
	%%%%%%%%%%%%%%%%%%
	%%plot histogram%%
	%%%%%%%%%%%%%%%%%%
  hist_ax(u) = subplot('Position', [leftside hist_bottom subplotwidth hist_height]);
  pe_th(unit,usedevents.(fn),secbefore,secafter,nbins);
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
for u = 1:num_events%first find largest y max
	yrange(u,1:2) = yrangeset;
end	
linkaxes(hist_ax,'y');%this way, changing one will change them all
set(hist_ax(1),'ylim',[0 max(yrange(:,1))]);



end %end of function