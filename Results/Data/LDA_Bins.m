%clearvars -except cell_megarat cell_megarat_mid
clearvars -except cell_megarat_bla cell_megarat_mid megarat cell_megarat_hpc cell_megarat_pir cell_megarat_cen
% load("cell_megarat_mid.mat")
cell_megarat=cell_megarat_pir;

    %% LDA
    %convertdataformat;
    TP=0;
    TN=0;
    FP=0;
    FN=0;
    numtrainlaps=20;                          %define the number of training trials (sets)
    numtestlaps=4;                           %define the number of test trials   (sets)
    numcells=30;                                %define the number of neurons
    numreps=1000;
    numbins=10;                                 %define the number of reps
    trainids=vertcat(ones(numtrainlaps,1),zeros(numtrainlaps,1)+2, zeros(numtrainlaps,1)+3, zeros(numtrainlaps,1)+4,zeros(numtrainlaps,1)+5,zeros(numtrainlaps,1)+6,zeros(numtrainlaps,1)+7,zeros(numtrainlaps,1)+8,zeros(numtrainlaps,1)+9,zeros(numtrainlaps,1)+10);
    testids=vertcat(ones(numtestlaps,1),zeros(numtestlaps,1)+2,zeros(numtestlaps,1)+3,zeros(numtestlaps,1)+4,zeros(numtestlaps,1)+5,zeros(numtestlaps,1)+6,zeros(numtestlaps,1)+7,zeros(numtestlaps,1)+8,zeros(numtestlaps,1)+9,zeros(numtestlaps,1)+10);
    for rep=1:numreps                                 %define how many reps you are going to execute
    trainmat=zeros(length(trainids),numcells);  %preallocate the training matrix
    testmat=zeros(length(testids),numcells);    %preallocate the test matrix
       for nn=1:numcells                           %go through each neuron                
       cellnum=randi(length(cell_megarat)); %pick a random neuron
      
        [numlaps,~] =size(cell_megarat{1,cellnum}.tenBin3FR); %find all of the trials for that stim type
           testlapsavail=1:10:numlaps;    %designate some of those as test trials
            trainlapsavail=1:numlaps;               %designate the rest as training trials
           trainlapsavail(testlapsavail)=[];           
          
          trainlapsuse=randsample(trainlapsavail, numtrainlaps); %pick the training trials
          testlapsuse=randsample(testlapsavail, numtestlaps); %pick the test trials
       for mbin=1:numbins
                         
         
          for i=1:length(trainlapsuse)
              trainmat(i+numtrainlaps*(mbin-1),nn)=cell_megarat{1,cellnum}.tenBin3FR(trainlapsuse(i),mbin); %find the fr for each neuron/
              if isnan(trainmat(i+numtrainlaps*(mbin-1),nn))
                  trainmat(i+numtrainlaps*(mbin-1),nn) = 0;
              end
                  %testmat(j+numtestlaps*(mbin-1),nn) =0;
                  %training trial and put it in the matrix
          end
         
          for j=1:length(testlapsuse)
              testmat(j+numtestlaps*(mbin-1),nn)=cell_megarat{1,cellnum}.tenBin3FR(testlapsuse(j),mbin); %find the fr for each neuron/
              if isnan(testmat(j+numtestlaps*(mbin-1),nn))
                  testmat(j+numtestlaps*(mbin-1),nn) =0;
              end                                                                                 %test trial and put it in the matrix
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
                       if testids(k)==0
                           TN = TN + 1;
                       end
                       if testids(k)==1
                           TP = TP + 1;
                       end
                   
           elseif class(k) ~= testids(k)
                       if testids(k)==0
                           FP = FP + 1;
                       end
                       if testids(k)==1
                           FN = FN + 1;
                       end
           end
           end
           percentcorrect=numcorrect/length(class); %find the percent correct
           results(rep)=percentcorrect; %store the percent correct
            
           shuffled_trainids=trainids(randperm(length(trainids)));  %create a random dataset
           [class, err]= classify(noisytestmat,noisytrainmat,shuffled_trainids,'linear'); %run the classifier
           s_numcorrect=0; %set the number of correct trials equal to zero
           for k=1:length(class)
               if class(k) == testids(k)  %compare the classifier's "guess" to the ground truth
                   s_numcorrect=s_numcorrect+1; %if it's right increase the counter
               end
           end 
           shuffled_percentcorrect=s_numcorrect/length(class); %find the percent correct
           shuffled_result(rep)=shuffled_percentcorrect; %store the percent correct
    
    end
%     precision = TP/(TP+FP)
%     recall=TP/(TP+FN)
%     F1=2*((precision*recall)/(precision+recall))
%     
%     figure; hist(results)
%     [h,p] = ttest2(results, shuffled_result)
%     resultsmap(numcells,1)=mean(results);
%     shuffled_resultsmap(numcells,1)=mean(shuffled_result);

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

% plot(resultsmap);
% xlabel("Cell Numbers");
% ylabel("Average Accuracy");
% title("Accuracy VS CellNum for BINS");
% 
% plot(shuffled_resultsmap);
% xlabel("Cell Numbers");
% ylabel("Average Accuracy");
% title("Shuffled Accuracy VS CellNum for BINS");