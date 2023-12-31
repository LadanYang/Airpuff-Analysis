% 
% cellidx=8;
% lap=cell_megarat_small{1,cellidx}.LtoRlaps;
% run=cell_megarat_small{1,cellidx}.videodata;
% %spike=cell_megarat_small{1,1}.spikes{1,1};
% pufloc=cell_megarat_small{1,cellidx}.airpuffloc;
% spikedata=cell_megarat_small{1,cellidx}.spikes{1,1};
% puff_raster(spikedata,lap,run,pufloc,"blue");
cell_megarat=cell_megarat_bla;
% writerObj = VideoWriter('PIR airpuff rast time vid.mp4');
% writerObj.FrameRate = 1;
%open(writerObj);

%cell_megerat=load("cell_megarat_mid_bla.mat").cell_megarat_mid_bla;
mode="airpuff"

if(mode=="airpuff")
    color='blue';
    shade='k';
    for c=128
        % 1:length(cell_megarat)
        if cell_megarat{1,c}.airpuffdir=="LtoR"
            lap=cell_megarat{1,c}.LtoRlaps;
            pufdir="L"
        end
        if cell_megarat{1,c}.airpuffdir=="RtoL"
            lap=cell_megarat{1,c}.RtoLlaps;
            pufdir="R"
        end
        run=cell_megarat{1,c}.videodata;
        pufloc=cell_megarat{1,c}.airpuffloc;
        spikedata=cell_megarat{1,c}.spikes{1,1};
        puff_raster(spikedata,lap,run,pufloc,"blue",pufdir,"Basolateral Amygdala cell128",shade);
        %puff_raster(spikedata,lap,run,pufloc,"blue",pufdir,["Cental Amygdala cell" num2str(c)],shade);
        fname = '/Users/yangladan/Desktop/Figures-Airpuff/CEN';
        %saveas(gcf, fullfile(fname, ['CEN_Cell' num2str(c)]), 'jpeg');
            %saveas(gcf, [vectorstring ' 0420 ' num2str(cellnum)], 'jpeg')
    %         close(gcf);
    %         frame=getframe(gcf);
    %         writeVideo(writerObj, frame);
    %         close(gcf); 
    end
    %close(writerObj);                                        
end
if(mode=="noairpuff")
    color='blue';
    shade='g';
    for c=1:length(cell_megarat)
        % 1:length(cell_megarat)
        if cell_megarat{1,c}.airpuffdir=="RtoL"
            lap=cell_megarat{1,c}.LtoRlaps;
            pufdir="L"
        end
        if cell_megarat{1,c}.airpuffdir=="LtoR"
            lap=cell_megarat{1,c}.RtoLlaps;
            pufdir="R"
        end
        run=cell_megarat{1,c}.videodata;
        pufloc=cell_megarat{1,c}.airpuffloc;
        spikedata=cell_megarat{1,c}.spikes{1,1};
        puff_raster(spikedata,lap,run,pufloc,"blue",pufdir,["PIR cell" num2str(c)],shade);
        fname = '/Users/yangladan/Desktop/Figures-NoAirpuff/PIR';
        saveas(gcf, fullfile(fname, ['PIR_Cell' num2str(c)]), 'jpeg');
            %saveas(gcf, [vectorstring ' 0420 ' num2str(cellnum)], 'jpeg')
    %         close(gcf);
    %         frame=getframe(gcf);
    %         writeVideo(writerObj, frame);
    %         close(gcf); 
    end
    %close(writerObj);        



end
                                                             