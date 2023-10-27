

for m=1:length(megarat)
%     session=megarat{1,m};
%     for c=1:length(session.tenBinFR)
%         FRdata=session.tenBinFR{1,b}';
%         for l=1:size(FRdata,2)
% 
%         end
%     end

    if megarat{1,m}.airpuffdir=="LtoR"
        lap=megarat{1,m}.LtoRlaps;
    elseif megarat{1,m}.airpuffdir=="RtoL"
        lap=megarat{1,m}.RtoLlaps;
    end
    
    cells=megarat{1,m}.spikes;
    xdata=megarat{1,m}.videodata;
    airbin=megarat{1,m}.airpuffbin;

    
    for l=1:length(lap)
        bin1=0;
        bin2=0;
        bin3=0;
        bin4=0;
        bin5=0;
        bin6=0;
        bin7=0;
        bin8=0;
        bin9=0;
        bin10=0;
        
        lapstart=lap(l,1);
        lapend=lap(l,2);
        laplength=lapend-lapstart;
       
        for c=1:length(cells)
            neuron=cells{1,c};
            lapcell=find(neuron(:,1)>=lapstart & neuron(:,1) <= lapend);


            binstart=round(lapstart*39.0625);
            binend=round(lapend*39.0625);
            bin=xdata(binstart:binend,1);
            a=neuron(lapcell,1);
            b=round(a*39.0625);
            bin1=length(find(xdata(b,1)>=200 & xdata(b,1) < 230));
            bin1time=length(find(bin(:,1)>=200 & bin(:,1)<230))/39.0625;    
            bin2=length(find(xdata(b,1)>=230 & xdata(b,1) < 260));
            bin2time=length(find(bin(:,1)>=230 & bin(:,1)<260))/39.0625;     
            bin3=length(find(xdata(b,1)>=260 & xdata(b,1) < 290));
            bin3time=length(find(bin(:,1)>=260 & bin(:,1)<290))/39.0625;     
            bin4=length(find(xdata(b,1)>=290 & xdata(b,1) < 320));
            bin4time=length(find(bin(:,1)>=290 & bin(:,1)<320))/39.0625;     
            bin5=length(find(xdata(b,1)>=320 & xdata(b,1) < 350));
            bin5time=length(find(bin(:,1)>=320 & bin(:,1)<350))/39.0625;     
            bin6=length(find(xdata(b,1)>=350 & xdata(b,1) < 380));
            bin6time=length(find(bin(:,1)>=350 & bin(:,1)<380))/39.0625;    
            bin7=length(find(xdata(b,1)>=380 & xdata(b,1) < 410));
            bin7time=length(find(bin(:,1)>=380 & bin(:,1)<410))/39.0625;     
            bin8=length(find(xdata(b,1)>=410 & xdata(b,1) < 440));
            bin8time=length(find(bin(:,1)>=410 & bin(:,1)<440))/39.0625;     
            bin9=length(find(xdata(b,1)>=440 & xdata(b,1) < 470));
            bin9time=length(find(bin(:,1)>=440 & bin(:,1)<470))/39.0625;     
            bin10=length(find(xdata(b,1)>=470 & xdata(b,1) < 500));
            bin10time=length(find(bin(:,1)>=470 & bin(:,1)<500))/39.0625;     
           
            %disp('part1check')
            megarat{1,m}.bin_spikes((l-1)*10+1,c)=bin1/bin1time;
            megarat{1,m}.bin_spikes((l-1)*10+2,c)=bin2/bin2time;
            megarat{1,m}.bin_spikes((l-1)*10+3,c)=bin3/bin3time;
            megarat{1,m}.bin_spikes((l-1)*10+4,c)=bin4/bin4time;
            megarat{1,m}.bin_spikes((l-1)*10+5,c)=bin5/bin5time;
            megarat{1,m}.bin_spikes((l-1)*10+6,c)=bin6/bin6time;
            megarat{1,m}.bin_spikes((l-1)*10+7,c)=bin7/bin7time;
            megarat{1,m}.bin_spikes((l-1)*10+8,c)=bin8/bin8time;
            megarat{1,m}.bin_spikes((l-1)*10+9,c)=bin9/bin9time;
            megarat{1,m}.bin_spikes((l-1)*10+10,c)=bin10/bin10time;
            %disp('check2')
            


            bin1=0;
            bin2=0;
            bin3=0;
            bin4=0;
            bin5=0;
            bin6=0;
            bin7=0;
            bin8=0;
            bin9=0;
            bin10=0;
        end
    end
    rows=size(megarat{1,m}.bin_spikes,1)
    megarat{1,m}.bin_output=zeros(rows,length(cells));
    %size(megarat{1,m}.bin_spikes,2)
    for t=1:rows
        if mod(t,airbin)==0
            megarat{1,m}.bin_output(t,:)=1;
        end
    end

end

% %draw out xdata for each session
% for m=1:length(megarat)
%     xda=megarat{1,m}.videodata;
%     %xda(xda(:,1)<0)=[];
%     x=find(xda(:,1)<0);
%     xda(x,:)=[];
%     figure
%     plot(xda(:,1));
%     title("Session"+m);
% end
% 
% for m=1:length(megarat)
%     megarat{1,m}.bin_output=[]
% 
% end
%      
