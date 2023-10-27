%clearvars -except cell_megarat cell_megarat_mid
clearvars -except cell_megarat_bla cell_megarat_mid megarat cell_megarat_hpc cell_megarat_pir cell_megarat_cen
%load("cell_megarat_mid.mat")
cell_megarat=cell_megarat_pir;
    %% NB
    %convertdataformat;

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
           noisytraintbl=array2table(noisytrainmat);
           noisytesttbl=array2table(noisytestmat);
           Mdl= fitcnb(noisytraintbl,trainids);
           [label,Posterior,Cost] = predict(Mdl,noisytestmat);


           numcorrect=0; %set the number of correct trials equal to zero
           for k=1:length(label)
               if label(k) == testids(k) %compare the classifier's "guess" to the ground truth
                   numcorrect=numcorrect+1; %if it's right increase the counter
                    
               end
           end

           
           percentcorrect=numcorrect/length(label); %find the percent correct
           results(rep)=percentcorrect; %store the percent correct
           
           noisytraintbl=array2table(noisytrainmat);
           noisytesttbl=array2table(noisytestmat);
           shuffled_trainids=trainids(randperm(length(trainids)));  %create a random dataset
           Mdl= fitcnb(noisytraintbl,shuffled_trainids); %run the classifier
           [label,Posterior,Cost] = predict(Mdl,noisytestmat);

  
           s_numcorrect=0; %set the number of correct trials equal to zero
           for k=1:length(label)
               if label(k) == testids(k)  %compare the classifier's "guess" to the ground truth
                   s_numcorrect=s_numcorrect+1; %if it's right increase the counter
               end
           end 
           shuffled_percentcorrect=s_numcorrect/length(label); %find the percent correct
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