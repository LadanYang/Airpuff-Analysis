writerObj = VideoWriter('airpuff rast time vid.avi');
writerObj.FrameRate = 1;
open(writerObj);

load("megarat.mat");
secbefore=5;
secafter=15;
color='blue';
cellnum=0;
for s=1:length(megarat)

    session=megarat{1,s};
    if megarat{1,s}.airpuffdir=="LtoR"
        events=session.LtoRlaps(:,1);
 
    elseif megarat{1,s}.airpuffdir=="RtoL"
        events=session.RtoLlaps(:,1);
    end
    %for c=1:length(session.spikes)
    for c=1:length(session.spikes)
        %cellnum=cellnum+c
        spikes=session.spikes{1,c};
        pe_raster2(spikes, events, secbefore, secafter, color)
        saveas(gcf, ['Session' num2str(s) 'cell' num2str(c)], 'jpeg');
        %saveas(gcf, [vectorstring ' 0420 ' num2str(cellnum)], 'jpeg')
        close(gcf);
        frame=getframe(gcf);
        writeVideo(writerObj, frame);
        close(gcf); 
    end

end
close(writerObj);                                                                                                                                                                                                                             