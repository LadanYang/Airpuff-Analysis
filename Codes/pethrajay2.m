function [hist_ax,rast_ax]=pethrajay2(units, u, event1, event2, secbefore, secafter, nbins)
%function pethra(unit,events, secbefore, secafter, nbins)
%plots a single perievent histogram/raster plot
%unit=stucture variable of all the units, each field has name and ts,
%  which is an array of spike timestamps
%event=array of timestamps for your specified event
% u is which unit number
%secbefore, secafter determine time window in seconds
%nbins=number of bins for the histogram
%calls both pe_th.m and pe_raster.m (which both call event_spikes.m)
%JRM 5-27-05
%JHB 7-30-14

%To Do:
%-label x axis if no other graph below

%determine layout of subplots



rast_height =.3;
hist_height =.3;
rast_bottom = .503;
hist_bottom= .2;
width=.3;
leftstart=.15;
rightstart=.60;

myfig = figure('OuterPosition',[500   250   750   512]);
%make sure we create a new figure to paint into plot the subplots


%first determine layout position for current figure

%then determine the actual coords


%%%%%%%%%%%%%%%%%%%
%%plot the raster%%
%%%%%%%%%%%%%%%%%%%

%%%%% left
rast_ax(1) = subplot('Position', [leftstart, rast_bottom, width, rast_height]);
pe_raster(units(u).ts,event1,secbefore,secafter,'k');
set(gca,'XTickLabel',[]);%don't print numbers on the raster x-axis

ylabel('trial number');
%set(gca,'Xcolor',[1 1 1]);%make the x tics white (not visible)
%put the unit number on the graph

%%%%% right
rast_ax(2) = subplot('Position', [rightstart rast_bottom,width,rast_height]);
pe_raster(units(u).ts,event2,secbefore,secafter,'k');
set(gca,'XTickLabel',[]);%don't print numbers on the raster x-axis

ylabel('trial number')
%set(gca,'Xcolor',[1 1 1]);%make the x tics white (not visible)
%put the unit number on the graph

%%%%%%%%%%%%%%%%%%
%%plot histogram%%
%%%%%%%%%%%%%%%%%%

%%%%%% left
hist_ax(1) = subplot('Position', [leftstart hist_bottom,width,hist_height]);
[~,~,maxrate(1)]=pe_th(units(u).ts,event1,secbefore,secafter,nbins);

xlabel('Time (seconds)');


ylabel('Hz');

%%%%%% right
hist_ax(2) = subplot('Position', [rightstart hist_bottom,width,hist_height]);
[~,~,maxrate(2)]=pe_th(units(u).ts,event2,secbefore,secafter,nbins);

xlabel('Time (seconds)');
maxrate=max(maxrate);
set(hist_ax(1),'ylim',[0 maxrate*1.2]);
set(hist_ax(2),'ylim',[0 maxrate*1.2]);
ylabel('Hz');


%make all the histograms have the same Y scale





end %end of function