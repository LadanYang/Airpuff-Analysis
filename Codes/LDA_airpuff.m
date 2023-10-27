

%% LDA
convertdataformat;

numtrainpertype=30;                          %define the number of training trials (sets)
numtestpertype=3;                           %define the number of test trials   (sets)
numcells=50;                                %define the number of neurons
numreps=5;                                  %define the number of reps

trainids=vertcat(zeros(numtrainpertype,1),ones(numtrainpertype,1));
testids=vertcat(zeros(numtestpertype,1), ones(numtestpertype,1));

for rep=1:numreps                                 %define how many reps you are going to execute
trainmat=zeros(length(trainids),numcells);  %preallocate the training matrix
testmat=zeros(length(testids),numcells);    %preallocate the test matrix

    for nn=1:numcells                           %go through each neuron                 
    cellnum=randi(length(spikedataall)); %pick a random neuron
    
    for m=1:2
        stimid=m-1;                 %find the stimulus identity for where you are in the list
        allstimtrials=find(infoall{1,cellnum}(:,1) == stimid); %find all of the trials for that stim type
        teststimavail=rep:20:length(allstimtrials);    %designate some of those as test trials
        trainstimavail=allstimtrials;               %designate the rest as training trials
        trainstimavail(teststimavail)=[];            
        
       trainstimtrials=randsample(trainstimavail, numtrainpertype); %pick the training trials
       teststimtrials=randsample(teststimavail, numtestpertype); %pick the test trials
       
       for i=1:length(trainstimtrials)
           trainmat(i+numtrainpertype*stimid,nn)=spikedataall{1,cellnum}(trainstimtrials(i),1); %find the fr for each neuron/ 
                                                                                                %training trial and put it in the matrix
       end
       
       for j=1:length(teststimtrials)
           testmat(j+numtestpertype*stimid,nn)=spikedataall{1,cellnum}(teststimtrials(j),1); %find the fr for each neuron/ 
                                                                                            %test trial and put it in the matrix
       end
    end
    end
    
        noisytestmat=addnoise(testmat); %add noise. zeros will create problems with the math
        noisytrainmat=addnoise(trainmat);  %add noise
        [class, err]= classify(noisytestmat, noisytrainmat, trainids, 'linear'); %run the classifier

        numcorrect=0; %set the number of correct trials equal to zero
        for k=1:length(class)
        if class(k) == testids(k) %compare the classifier's "guess" to the ground truth
        numcorrect=numcorrect+1; %if it's right increase the counter
        end
        end 
        percentcorrect=numcorrect/length(class); %find the percent correct

        results(rep)=percentcorrect; %store the percent correct
       
end
figure; hist(results)