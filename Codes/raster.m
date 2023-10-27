function [h,spikematrix] = raster(spikes,eventstart,varargin)
%RASTER Creates a perievent raster plot
%   
%spikes - vector of spike timestamps
%eventstart - vector of event start times
%
%   *NOTE: All code dealing with 'epochs' solely pertains to the graphical
%   output of the raster.  These 'epochs' will be shaded behind the rasters
%   ticks to highlight epochs of interest.  In contrast, 'events' define 
%   the relative timestamps that form the basis of the plot, and critically 
%   dictate the data that is plotted.
%   
%   Optional inputs (entered as dyads through varargin):
%eventend - vector of event end times (must be same length at eventstart)
%afterevent - scalar. Time after event to be included in raster.  May be
%           used in lieu of "eventend", or in conjunction with "eventend"
%beforeevent - scalar. Time before event to be included in raster
%spiketag - vector equal to the size of "spikes". Numerically indexes each 
%           spike so that it can be colored according to "spikecolors".  A
%           spike tagged with a NaN will not be plotted.
%spikecolors - Nx3 matrix of RGB values, where N is the maximal "spiketag".
%           If "spiketag" is provided with no "spikecolors" colormap, the
%           "lines" colormap will be used.
%epochmarks - Mx2 matrix.  Start and stop times for epochs of interest.  If
%           an epoch occurs within a raster trial, a shaded rectangle will
%           underly the raster demarcating the epoch.
%epochcolors - 1x3 or Mx3 matrix.  Color(s) for epochs of interest in RGB
%           triad.  May either be a single color for all epochs, or a color
%           can be defined for each individual epoch.
%eventcolor - 1x3 vector.  Color of lines delineating the beginning and end
%           of event in each trial.  If vector contains NaN, then no event
%           lines will be produced.
%reordertrial - vector equal to the number of events.  Allows the raster 
%           plot to be reordered, allowing trials to be grouped.
%axeshandle - handle identifying which axis object is used for raster.  If 
%           no handle is created, then a new figure will be created.
%
%Jon Rueckemann 2014

%Default values
beforeevent=0;
afterevent=0;
epochcolors=[0.97 0.97 0.97];
eventcolor=[0 0 1];
%#ok<*NODEF,*AGROW>

%Process input variables
namevars=extractvarargin(varargin,true);

%Verify input format
assert(isnumeric(spikes),'"spikes" must be a vector of spike timestamps');
assert(isnumeric(eventstart),['"eventstart" must be a vector of '...
    'timestamps indicating the beginning of each trial']);
assert(isscalar(beforeevent),['The "beforeevent" duration must be a '...
    'scalar.']);
assert(isscalar(afterevent),'The "afterevent" duration must be a scalar.');

%Ensure that there is an end to each trial
if ~any(strcmpi('eventend',namevars))&&~any(strcmpi('afterevent',namevars))
    error(['There must be an "eventend" or an "afterevent" variable to '...
        'demarcate the end of each raster event.']);
elseif any(strcmpi('eventend',namevars))
    assert(numel(eventend)==numel(eventstart),['There must be an equal '...
        'number of start and end events, if end events are used.']); 
else
    assert(afterevent>0,['If "afterevent" is the only indicator for the'...
        'end of a trial, it must be a value greater than 0.']);
    eventend=eventstart; %(afterevent will be added to eventstart)
end

%Ensure that the reordering vector is in the correct format
if any(strcmpi('reordertrial',namevars))
    assert(numel(reordertrial)==numel(eventstart),['There must be a '...
        '"reordertrial" index for each event.']);
    %Convert categorical reordering to trial index
    [~,reordertrial]=sort(reordertrial); %reorder by category
    [~,reordertrial]=sort(reordertrial); %invert indexing
    reordertrial=reordertrial(:);
else
    reordertrial=(1:numel(eventstart))';
end      

%Modify raster beginning and ending times
eventstart=eventstart(:);
eventend=eventend(:);
% this just widens the window
rasterstart=eventstart-beforeevent;
rasterend=eventend+afterevent;

%Prepare spiking data for raster
[trialidx,trialtime]=tagts(spikes,rasterstart,rasterend);
trialtime=trialtime-beforeevent; %make trial time relative to event start

%Prepare axes for plotting
if any(strcmpi('axeshandle',namevars))
    h.fig=get(axeshandle,'Parent');
    h.axes=axeshandle;
else
    h.fig=figure;
    h.axes=axes;
end
set(h.axes,'ydir','reverse',...
    'xlim',[-beforeevent max(eventend-eventstart)+afterevent],...
    'ylim',[1 numel(eventstart)+1]);
hold(h.axes,'on');

%If there is no spiking during event period, end function
if all(isnan(trialidx))
    hold(h.axes,'off');
    return
end

%Exclude spiking data not in raster
inraster=~isnan(trialidx);
trialidx=trialidx(inraster);
trialtime=trialtime(inraster);

%Prepare color labeling of individual spikes
if any(strcmpi('spiketag',namevars))
    assert(isnumeric(spiketag),'"spiketag" must be a numeric vector.');
    assert(numel(spiketag)==numel(spikes),['There must be a "spiketag" '...
        'for each entry in "spikes".']);
    
    %Exclude spike tags that are not in raster
    spiketag=spiketag(inraster);
    
    %Define spike colormap
    if ~any(strcmpi('spikecolors',namevars))
        spikecolors=lines(nanmax(unique(spiketag)));
        [~,~,spiketag]=unique(spiketag);
    end
    assert(size(spikecolors,2)==3,'"spikecolor" must be an NX3 matrix.')
    if ~isnan(nanmax(spiketag))
        assert(nanmax(spiketag)<=size(spikecolors,1),['There must be'...
            ' a "spikecolor" for each type of "spiketag".']);
    end
else
    spiketag=ones(size(trialidx));
    spikecolors=[0 0 0];
end

%Apply reorder index to trialidx
trialidx=reordertrial(trialidx);

%Reorder event bounding timestamps
eventstart=eventstart(reordertrial);
eventend=eventend(reordertrial);

%Use epoch data to create background rectangles
if any(strcmpi('epochmarks',namevars))
    %Verify epoch data is in the correct format.
    assert(size(epochmarks,2)==2,['The epochmarks must have two columns'...
        ' corresponding to the start and end of each epoch.']);
    if size(epochcolors,1)==1
        epochcolors=repmat(epochcolors,size(epochmarks,1),1);
    end
    assert(size(epochcolors,2)==3,'epochcolors must be in RGB triads.');
    assert(size(epochmarks,1)==size(epochcolors,1),['There must be a '...
        'color corresponding to each epoch in epochmarks.']);
    
    %Find epochs that occur during trials
    epochmarks=epochmarks';
    epochmarks=epochmarks(:);
    [epochtrialidx,epochtimes]=tagts(epochmarks,rasterstart,rasterend);
    epochtimes=epochtimes-beforeevent; %makes time relative to event start
    epochtimes=reshape(epochtimes,2,numel(epochtimes)/2)';
    epochtrialidx=reshape(epochtrialidx,2,numel(epochtrialidx)/2)';
    
    %Remove epochs that do not occur during trials
    epochcolors(all(isnan(epochtrialidx),2),:)=[];
    epochtimes(all(isnan(epochtrialidx),2),:)=[];
    epochtrialidx(all(isnan(epochtrialidx),2),:)=[];
    
    
    %Split epochs that span multiple trials
    trialspan=diff(epochtrialidx,1,2);
    multitrialidx=epochtrialidx(trialspan>0,:);
    multitrialtimes=epochtimes(trialspan>0,:);
    epochtrialidx(trialspan>0,:)=[]; %Temporarily remove multitrial epochs
    epochtimes(trialspan>0,:)=[]; %Temporarily remove multitrial epochs
    for x=1:size(multitrialidx,1) %Draw epoch rectangles in multiple trials
        appendidx=[(multitrialidx(x,1):multitrialidx(x,2))'...
            (multitrialidx(x,1):multitrialidx(x,2))'];
        appendtimes=nan(size(appendidx));
        appendtimes(1)=multitrialtimes(x,1);
        appendtimes(end)=multitrialtimes(x,2);
        epochtrialidx=[epochtrialidx; appendidx];
        epochtimes=[epochtimes; appendtimes];
    end
    
    %Insert missing values for epochs that start/end outside plotting range
    temptrialidx=flip(epochtrialidx,2);
    epochtrialidx(isnan(epochtrialidx))=temptrialidx(isnan(epochtrialidx));
    epochtimes(isnan(epochtimes(:,1)),1)=rasterstart(epochtrialidx(isnan(epochtimes(:,1))));
    epochtimes(isnan(epochtimes(:,2)),2)=rasterend(epochtrialidx(isnan(epochtimes(:,2))));
    
    %Apply reorder index to epochs
    epochtrialidx=reordertrial(epochtrialidx);
    
    %Format epoch data for patch function
    xpatch=[epochtimes'; flip(epochtimes',1)];
    ypatch=[epochtrialidx'; epochtrialidx'+1];
    
    %Plot epoch rectangles
    epochcolors=reshape(epochcolors,1,size(epochcolors,1),3);
    if numel(xpatch)~=numel(ypatch)
        disp('ow')
    end
    h.epochs=patch(xpatch,ypatch,epochcolors,'linestyle','none'); %Each column is a patch
else
    h.epochs=[];
end
    
%Create raster
uniqtag=unique(spiketag(~isnan(spiketag)));
for m=1:numel(uniqtag)
    %Select data by spike tag
    idx=spiketag==uniqtag(m);
    curtime=trialtime(idx);
    curtrial=trialidx(idx);
    
    %Format input
    X=repmat(curtime',3,1);
    X=X(:);
    Y=[curtrial';curtrial'+1;nan(size(curtrial'))];
    Y=Y(:);
    
    %Plot spikes in different colors by tag
    h.line(m)=line(X,Y,'Parent',h.axes,'Color',spikecolors(uniqtag(m),:));
end

if all(~isnan(eventcolor))
    %Mark event starts
    h.eventstart=line([0 0],[1 numel(eventstart)+1],'Parent',h.axes,'linewidth',2,'Color',eventcolor);
    
    %Mark event ends
    X=repmat((eventend-eventstart)',3,1);
    X=X(:);
    Y=[reordertrial'; reordertrial'+1; nan(1,numel(eventstart))];
    Y=Y(:);
    h.eventend=line(X,Y,'Parent',h.axes,'linewidth',2,'Color',eventcolor);
end

spikematrix=[trialidx trialtime spiketag];

hold(h.axes,'off');
end