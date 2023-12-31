%  writerObj = VideoWriter('4 stim rast 1 hist vid.avi');
%  writerObj.FrameRate = 1;
%  set the seconds per image
%  secsPerImage = [5 10 15];
%  open the video writer
%  open(writerObj);
%load('latemutcsbothmodel257.mat')

%vectorofcells=[37;105;131;189;219;250;259;270;562;734;754];
vectorofcells=37;
vectorstring='selected figure 1 rasters ';

 loadeddata=fileread('cell_fits_recall.json');
 cellfits=jsondecode(loadeddata);
fn=fieldnames(cellfits);
nn=numel(fn);

smtmat1=zeros(nn, 6); 

for k=1:nn
    
    smtmat1(k, 1)=cellfits.(fn{k}).GaussianFirstStimBoth.sigma1;   
    smtmat1(k, 2)=cellfits.(fn{k}).GaussianFirstStimBoth.mu1;
    %smtmat(k, 3)=cellfits.(fn{k}).GaussianStimBoth.sigma2;   
    %smtmat(k, 4)=cellfits.(fn{k}).GaussianStimBoth.mu2;
    smtmat1(k, 3)=0;   
    smtmat1(k, 4)=0;
    smtmat1(k, 5)=1;
    smtmat1(k, 6)=k;
    smtmat1(k,7)=cellfits.(fn{k}).GaussianFirstStimBoth.a_0;
    smtmat1(k,8)=cellfits.(fn{k}).GaussianFirstStimBoth.a_1;
    smtmat1(k,9)=cellfits.(fn{k}).GaussianFirstStimBoth.a_2;
    smtmat1(k,10)=cellfits.(fn{k}).GaussianFirstStimBoth.a_3;
    smtmat1(k,11)=cellfits.(fn{k}).GaussianFirstStimBoth.a_4;
    
    
end
for i=1:length(vectorofcells)
    cellnum=vectorofcells(i);


load spikedataall.mat
spikesforcell=spikedataall{1,cellnum}.cellfits; 
 

     
fitvals1=zeros(3000,2);
sig1=smtmat1(cellnum, 1);
mu1=smtmat1(cellnum, 2);
% sig2=smtmat(cellnum, 3);
% mu2=smtmat(cellnum, 4);
%tau=smtmat1(cellnum, 3);
tau=1;
a10=smtmat1(cellnum, 7);
a11=smtmat1(cellnum, 8);
a12=smtmat1(cellnum, 9);
a13=smtmat1(cellnum, 10);
a14=smtmat1(cellnum, 11);


for t=1:3000
    ts=t;
    fitvals11(t,1)=ts;
    fitvals11(t,2)=a10+a11*exp((-(ts-mu1)^2)/(2*sig1^2));
end

for t=1:3000
    ts=t;
    fitvals12(t,1)=ts;
    fitvals12(t,2)=a10+a12*exp((-(ts-mu1)^2)/(2*sig1^2));
end

for t=1:3000
    ts=t;
    fitvals13(t,1)=ts;
    fitvals13(t,2)=a10+a13*exp((-(ts-mu1)^2)/(2*sig1^2));
end

for t=1:3000
    ts=t;
    fitvals14(t,1)=ts;
    fitvals14(t,2)=a10+a14*exp((-(ts-mu1)^2)/(2*sig1^2));
end

load('infoall.mat')

stimids1=zeros(nn,1);

    fnn=fieldnames(infodata.(fn{cellnum}));
    ne=numel(fnn);
    for j=1:ne
    stimid1=infodata.(fn{cellnum}).(fnn{j}).sample(1,1);
    stimids1(j,1)=stimid1;
    end


figure;
allthehandles{1,cellnum}=gcf;
icecream=1;
%condition 1    
    

    subplot(3,1,1);
    hFig = subplot(3,1,1);
    % set(hFig, 'Position', [0.1 0.5 0.5 0.4]);
     set(hFig,'XTick',[],'XTickLabel',[]);
%     set(gca,'fontsize', 14);
    [spike_times] = pe_raster2_WM_stim( spikesforcell, 0, 3000, 'black', stimids1);
    spike_times_all{icecream} = spike_times;
    ylabel('Samples'); 
   
    title(['Cell ' num2str(cellnum)])

    subplot(3,1,2);
    hFig = subplot(3,1,2); 
   %   set(hFig, 'Position', [0.1 0.4 0.25 0.25]);
%     set(gca,'fontsize', 14);
    [allfoundspikes] = Gauss_hist_stim(spikesforcell, 0, 3000, 100, stimids1); %epo is big reward or dig, 
    allfoundspikes_all{icecream} = allfoundspikes;
        ylabel('Hz');
         xlabel('Time (ms)')
        %ylim([0 20]);
      


    subplot(3,1,3);
    hFig = subplot(3,1,3);
   % set(hFig, 'Position', [0.1 0.05 0.5 0.4]);
    plot(fitvals11(:,1), fitvals11(:,2),'r');
    hold on
    plot(fitvals12(:,1), fitvals12(:,2),'k');
    hold on
    plot(fitvals13(:,1), fitvals13(:,2),'b');
    hold on
    plot(fitvals14(:,1), fitvals14(:,2),'g');
   

    
    
    
  %saveas(gcf, ['timecell 0.001 rasthistfits' num2str(cellnum)], 'fig');
  %saveas(gcf, [vectorstring ' 0420 ' num2str(cellnum)], 'jpeg')
  % close(gcf);
%     frame=getframe(gcf);
%     writeVideo(writerObj, frame);
%     close(gcf); 
%     hold on
%     plot(fitvalse(:,1), fitvalse(:,2), 'r');
%     hold on
%     plot(fitvalso(:,1), fitvalso(:,2), 'y');
end


%  close(writerObj);                                                                                                                                                                                                                                                                                                                                                                                                                                                                              