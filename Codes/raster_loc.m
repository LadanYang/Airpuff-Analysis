% 
% cellidx=8;
% lap=cell_megarat_small{1,cellidx}.LtoRlaps;
% run=cell_megarat_small{1,cellidx}.videodata;
% %spike=cell_megarat_small{1,1}.spikes{1,1};
% pufloc=cell_megarat_small{1,cellidx}.airpuffloc;
% spikedata=cell_megarat_small{1,cellidx}.spikes{1,1};
% puff_raster(spikedata,lap,run,pufloc,"blue");
cell_megarat=cell_megarat_hpc;
% writerObj = VideoWriter('PIR airpuff rast time vid.mp4');
% writerObj.FrameRate = 1;
%open(writerObj);

%cell_megerat=load("cell_megarat_mid_bla.mat").cell_megarat_mid_bla;


color='blue';

for c=70
    % 1:length(cell_megarat)
    if cell_megarat{1,c}.airpuffdir=="LtoR"
        lap=cell_megarat{1,c}.LtoRlaps;
    end
    if cell_megarat{1,c}.airpuffdir=="RtoL"
        lap=cell_megarat{1,c}.RtoLlaps;
    end
    run=cell_megarat{1,c}.videodata;
    pufloc=cell_megarat{1,c}.airpuffloc;
    spikedata=cell_megarat{1,c}.spikes{1,1};
    puff_raster(spikedata,lap,run,pufloc,"blue");
    %saveas(gcf, ['PIR_Cell' num2str(c)], 'jpeg');
        %saveas(gcf, [vectorstring ' 0420 ' num2str(cellnum)], 'jpeg')
%         close(gcf);
%         frame=getframe(gcf);
%         writeVideo(writerObj, frame);
%         close(gcf); 
end
%close(writerObj);                                                                                                     