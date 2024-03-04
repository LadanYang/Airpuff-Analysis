clearvars -except cell_megarat_high session_high 
acum=0; %use this to accumulate the total number of laps/reps, for indicator in percent correct
k=10;
for s=1:length(session_high)
    cells=session_high{1,s};
    cellnums=length(cells);
    numlaps=height(cells{1,1}.tenBin3FR);
    foldsize=floor(numlaps/k)
    %shuffle the rows of data
%     idx = randperm(size(data, 1));
%     shuffledData = data(idx, :);
    acum=acum+numlaps;
    %cellmax=floor(min(0.9*numlaps,cellnums));  %set the cell max to be less than the number of laps
    cellmax=30
    cellints=randsample(cellnums,cellmax);
    for l=1:k
            trainmat=zeros(10*foldsize*(k-1),cellmax);
            testmat=zeros(10*foldsize,cellmax);
            lapsavil=1:k*foldsize;
            testlaps=(l-1)*foldsize+1:l*foldsize;
            lapsavil(testlaps)=[];
            binids=(1:10)';
            testids=repmat(binids,foldsize,1);
            trainids=repmat(binids,foldsize*(k-1),1);
            results=zeros(k*length(session_high));
            shuffled_result=zeros(k*length(session_high));
        for i=1:cellmax
            c=cellints(i);
            for f=1:foldsize
                %note index cant be zero so it is not 10(f-1)
                testmat(10*f-9:f*10,i)=cells{1,c}.tenBin3FR((k-1)*foldsize+f,:)';
            end
             %get the lth lap's firing data as the test mat
%             for tt=1:10
%                 if isnan(testmat(tt,:))
%                     testmat(tt,:)=0;
%                 end
%             end
            for d=1:length(lapsavil)
                lap=lapsavil(d);
                trainmat(10*d-9:10*d,i)=cells{1,c}.tenBin3FR(lap,:)';
%                 if isnan(trainmat(10*d-9:10*d,i))
%                   trainmat(10*d-9:10*d,i)=0;
%                 end
            end
%             for dd=1:height(trainmat)
%                 if isnan(trainmat(dd,:))
%                     trainmat(dd,:)=0;
%                 end
%             end
        end
            noisytestmat=addnoise(testmat); %add noise. zeros will create problems with the math
               
            noisytrainmat=addnoise(trainmat);  %add noise
            [class, err]= classify(noisytestmat, noisytrainmat, trainids, 'linear'); %run the classifier
            numcorrect=0; %set the number of correct trials equal to zero
            for kc=1:length(class)
           if class(kc) == testids(kc) %compare the classifier's "guess" to the ground truth
           numcorrect=numcorrect+1; %if it's right increase the counter
%                        if testids(k)==0
%                            TN = TN + 1;
%                        end
%                        if testids(k)==1
%                            TP = TP + 1;
%                        end
%                    
%            elseif class(k) ~= testids(k)
%                        if testids(k)==0
%                            FP = FP + 1;
%                        end
%                        if testids(k)==1
%                            FN = FN + 1;
%                        end
           end
           end
           percentcorrect=numcorrect/length(class); %find the percent correct
           results(acum-numlaps+l)=percentcorrect; %store the percent correct 

           shuffled_trainids=trainids(randperm(length(trainids)));  %create a random dataset
           [class, err]= classify(noisytestmat,noisytrainmat,shuffled_trainids,'linear'); %run the classifier
           s_numcorrect=0; %set the number of correct trials equal to zero
           for kc=1:length(class)
               if class(kc) == testids(kc)  %compare the classifier's "guess" to the ground truth
                   s_numcorrect=s_numcorrect+1; %if it's right increase the counter
               end
           end 
           shuffled_percentcorrect=s_numcorrect/length(class); %find the percent correct
           shuffled_result(acum-numlaps+l)=shuffled_percentcorrect; %store the percent correct

    end
end

figure; 
    hist(results);
    
    xlim([0, 1]);
    % xlabel('Data Value', 'FontSize', 14);
    % ylabel('Bin Count', 'FontSize', 14);
    title('Airpuff Accuracy', 'FontSize', 14);
    
    
    figure; 
    hist(shuffled_result);
    
    xlim([0, 1]);
    % xlabel('Data Value', 'FontSize', 14);
    % ylabel('Bin Count', 'FontSize', 14);
    title('Shuffled Accuracy', 'FontSize', 14);
    
    [h,p] = ttest2(results, shuffled_result)
    resultsmap(numcells,1)=mean(results);
    shuffled_resultsmap(numcells,1)=mean(shuffled_result);