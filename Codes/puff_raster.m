% lap=load("Rat08-20130708-Laps.mat").LtoRlaps;
% run=load("Rat08-20130708.whl.txt");
% spike=load("Rat08-20130708.cell_metrics.cellinfo.mat").cell_metrics.spikes.times;
% airpuff=load("airpuff.mat").airpuff;
% spikedata=spike{1,1};
function [spike_times] = puff_raster(spikedata, lap, run, pufloc, color,pufdir,cellinfo,shade)
close all
for i=1:length(spikedata)

    idx=spikedata(i,1)*39.0625;
    spikex(i,1)=spikedata(i,1);
    if round(idx)~=0
        spikex(i,2)=run(round(idx),1);
    end
end

num_events = length(lap);
hold on
%spike_loc = spikex;
spike_loc = [];

%pufloc=airpuff.loc;
locbefore=pufloc-10;
locafter=pufloc+10;
for ev_num = 1:num_events
    tempspikes=[];
    spikk=[];
    trial=ev_num;
    
    %spikesc=spikes(trial,1);
    spikesev=find(spikex(:,1)>lap(trial,1) & spikex(:,1)<lap(trial,2));
    if (length(spikesev)>0)
        for s=1:length(spikesev)
            index=spikesev(s,1);
            spikk(s,1)=spikex(index,1);
            spikk(s,2)=spikex(index,2);
        end
    
        %spikk
	    %find the spikes within a location window around airpuff
	    %tempspikes = spikk(spikk(:,2)>=locbefore & spikk(:,2)<=locafter);
        tempspikes = spikk(:,2);
    
        %find the offset (in secs) from the current event
	    found = 0;
	    if (tempspikes > 0)
		    found = 1;
		    tempspikes = tempspikes- 0;
            spike_loc = [spike_loc; tempspikes];
            
		    lineheight = [zeros(1,length(tempspikes)); .95*ones(1,length(tempspikes))]+ ev_num;
            %lineheight is two rows, the first row is a vector of zeros the
            %length of tempspikes. The second row is just 0.95 more of the
            %first row.
            
            linehandle = line([tempspikes'; tempspikes'], lineheight, 'Linewidth', 1.4); %changed from 1.2 0518
            %linehandle generates a line image that must have the same
            %dimensions as lineheight. Therefore, we have transposed tempspikes
            %to become a row vector.
            
		    set(linehandle, 'color', color);
        end%end of if found
        
     end
end%end of for loop
 % Add shading to the left of xline(pufloc)
    % Add shading to the left of xline(pufloc)
    if (pufdir=="R")
        left_shaded_area_x = [0, pufloc, pufloc, 0];
        left_shaded_area_y = [0, 0, num_events + 1, num_events + 1];
        area=patch(left_shaded_area_x, left_shaded_area_y, shade, 'FaceAlpha', 0.2, 'EdgeColor', 'none');


    end

       % Add shading to the right of xline(pufloc)
     if (pufdir=="L")
         right_shaded_area_x = [pufloc, 600, 600, pufloc];
         right_shaded_area_y = [0, 0, num_events + 1, num_events + 1];
         area=patch(right_shaded_area_x, right_shaded_area_y, shade, 'FaceAlpha', 0.2, 'EdgeColor', 'none');

     end
    loc=xline(pufloc, 'r',LineWidth=2); % Add a vertical line at pufloc with a red color
    xlabel('Location',FontSize=18,FontWeight='bold');
    ylabel('Lap',FontSize=18,FontWeight='bold');
    title(cellinfo,FontSize=20);

    xlim([0 600]);
    ylim([0 num_events + 1]);
%     [h_legend,~] = legend('area1','area2');
%     PatchInLegend = findobj(h_legend, 'type', 'patch');
%     set(PatchInLegend(1), 'FaceAlpha', 0.2);
%     set(PatchInLegend(2), 'FaceAlpha', 0.4);
    
    legend([area,loc],'After Airpuff',"Airpuff");
    hold off