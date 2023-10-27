
%make a histogram of lap length distribution for LtoR
cnt=0;
for s=1:17
    LtoR=megarat{1,s}.LtoRlaps;
    for l=1:length(LtoR)
        laplength(cnt+l,1)=LtoR(l,2)-LtoR(l,1);
    end
    cnt=cnt+length(LtoR);
end

%make a histogram of lap length distribution for RtoL
cnt=0;
for s=1:17
    RtoL=megarat{1,s}.RtoLlaps;
    for l=1:length(RtoL)
        Rlaplength(cnt+l,1)=RtoL(l,2)-RtoL(l,1);
    end
    cnt=cnt+length(RtoL);
end
histogram(Rlaplength);

%histogram of lap length both direction
lapall=vertcat(laplength,Rlaplength);
histogram(lapall);


%make a histogram of lap length with airpuff
cnt=0;
for s=1:17
    if megarat{1,s}.airpuffdir=="LtoR"
        lap=megarat{1,s}.LtoRlaps;
 
    elseif megarat{1,s}.airpuffdir=="RtoL"
        lap=megarat{1,s}.RtoLlaps;
    end
    for l=1:length(lap)
        pufflap(cnt+l,1)=lap(l,2)-lap(l,1);
    end
    cnt=cnt+length(lap);
end
histogram(pufflap);

%make a histogram of #cells vs #laps
cnt=0;
for s=1:17
    if megarat{1,s}.airpuffdir=="LtoR"
        lap=megarat{1,s}.LtoRlaps;
 
    elseif megarat{1,s}.airpuffdir=="RtoL"
        lap=megarat{1,s}.RtoLlaps;
    end
    for c=1:length(megarat{1,s}.spikes)
        
        lapcount(c+cnt,1)=length(lap);
    end
    cnt=cnt+length(megarat{1,s}.spikes);
end
histogram(lapcount);