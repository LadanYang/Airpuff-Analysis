function [hist_ax,rast_ax]=pethrajay(units, u, event, secbefore, secafter, nbins)
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





myfig = figure;
%make sure we create a new figure to paint into plot the subplots


%first determine layout position for current figure
rast_height =.3;
hist_height =.3;
rast_bottom = .5;
hist_bottom= .2;
width=.5;
left=.25;
%then determine the actual coords


%%%%%%%%%%%%%%%%%%%
%%plot the raster%%
%%%%%%%%%%%%%%%%%%%
rast_ax = subplot('Position', [left rast_bottom,width,rast_height]);
spiketimes=pe_raster(units(u).ts,event,secbefore,secafter);
set(gca,'XTick',-secbefore:1:secafter);% set x ticks so we can match plots

set(gca,'XTickLabel',[]);%don't print numbers on the raster x-axis

ylabel('trial number')
%set(gca,'Xcolor',[1 1 1]);%make the x tics white (not visible)
%put the unit number on the graph


%%%%%%%%%%%%%%%%%%
%%plot histogram%%
%%%%%%%%%%%%%%%%%%
hist_ax = subplot('Position', [left hist_bottom,width,hist_height]);

[times,rates,maxrate]=pe_th(units(u).ts,event,secbefore,secafter,nbins);
%plot(times,smooth(rates));
plot(times,rates);
xlabel('Time (seconds)');
if max(rates)==0
    close
    return
end
% set the y axis of the histogram
set(hist_ax,'ylim',[0 maxrate+maxrate*.2]);
ylabel('Hz');
set(gca,'XTick',-secbefore:1:secafter);% set x ticks so we can match plots
xlim([-secbefore secafter]);




end %end of function