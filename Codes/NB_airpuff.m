clearvars -except cell_megarat_bla cell_megarat_mid megarat cell_megarat_hpc cell_megarat_pir cell_megarat_cen

% load("cell_megarat_mid.mat")
cell_megarat=cell_megarat_pir;
%for numcells=1:35
%% LDA
%convertdataformat;
    TP=0;
    TN=0;
    FP=0;
    FN=0;
    numtrainlaps=10;                          %define the number of training trials (sets)
    numtestlaps=2;                           %define the number of test trials   (sets)
    numcells=18;                                %define the number of neurons
    numreps=1000;                             %define the number of reps
    numbins=10;                                 
    trainids=vertcat(zeros(numtrainlaps,1),ones(numtrainlaps,1));
    testids=vertcat(zeros(numtestlaps,1), ones(numtestlaps,1));
    
    for rep=1:numreps                                 %define how many reps you are going to execute
    trainmat=zeros(length(trainids),numcells);  %preallocate the training matrix
    testmat=zeros(length(testids),numcells);    %preallocate the test matrix
       for nn=1:numcells                           %go through each neuron                
        allbins=[1,2,3,4,5,6,7,8,9,10];
        cellnum=randi(length(cell_megarat)); %pick a random neuron
        airbin=cell_megarat{1,cellnum}.airpuffbin;  %find the airpuff bin
        allbins(airbin)=[]; %get non airpuff bins
        nonairbin=randi(length(allbins)); %randomly select index for non-airpuff bin
        [numlaps,~] =size(cell_megarat{1,cellnum}.tenBin3FR); %find the number of total laps
        %[numlaps,~] =size(cell_megarat{1,cellnum}.puffTenBinsFR); %find the number of total laps
           testlapsavail=1:10:numlaps;    %designate some of those as test trials
            trainlapsavail=1:numlaps;               %designate the rest as training trials
           trainlapsavail(testlapsavail)=[];           
          
          trainlapsuse=randsample(trainlapsavail, numtrainlaps); %pick the training trials
          testlapsuse=randsample(testlapsavail, numtestlaps); %pick the test trials
       for mbin=1:2
          if mbin==1 %for non-airpuff bin
              for i=1:length(trainlapsuse)
                  trainmat(i+numtrainlaps*(mbin-1),nn)=cell_megarat{1,cellnum}.tenBin3FR(trainlapsuse(i),allbins(nonairbin)); %find the fr for each neuron/
                  %trainmat(i+numtrainlaps*(mbin-1),nn)=cell_megarat{1,cellnum}.puffTenBinsFR(trainlapsuse(i),allbins(nonairbin)); %find the fr for each neuron/
                  if isnan(trainmat(i+numtrainlaps*(mbin-1),nn))
                      trainmat(i+numtrainlaps*(mbin-1),nn) = 0;
                  end
                      %testmat(j+numtestlaps*(mbin-1),nn) =0;
                      %training trial and put it in the matrix
              end
         
              for j=1:length(testlapsuse)
                  testmat(j+numtestlaps*(mbin-1),nn)=cell_megarat{1,cellnum}.tenBin3FR(testlapsuse(j),allbins(nonairbin)); %find the fr for each neuron/
                  %testmat(j+numtestlaps*(mbin-1),nn)=cell_megarat{1,cellnum}.puffTenBinsFR(testlapsuse(j),allbins(nonairbin)); %find the fr for each neuron/
                  if isnan(testmat(j+numtestlaps*(mbin-1),nn))
                      testmat(j+numtestlaps*(mbin-1),nn) =0;
                  end                                                                                 %test trial and put it in the matrix
              end
          end
    
          if mbin==2 %for airpuffbin
    
              for i=1:length(trainlapsuse)
                  trainmat(i+numtrainlaps*(mbin-1),nn)=cell_megarat{1,cellnum}.tenBin3FR(trainlapsuse(i),airbin); %find the fr for each neuron/
                  %trainmat(i+numtrainlaps*(mbin-1),nn)=cell_megarat{1,cellnum}.puffTenBinsFR(trainlapsuse(i),airbin); %find the fr for each neuron/
                  if isnan(trainmat(i+numtrainlaps*(mbin-1),nn))
                      trainmat(i+numtrainlaps*(mbin-1),nn) = 0;
                  end
                      %testmat(j+numtestlaps*(mbin-1),nn) =0;
                      %training trial and put it in the matrix
               end
         
              for j=1:length(testlapsuse)
                  testmat(j+numtestlaps*(mbin-1),nn)=cell_megarat{1,cellnum}.tenBin3FR(testlapsuse(j),airbin); %find the fr for each neuron/
                  %testmat(j+numtestlaps*(mbin-1),nn)=cell_megarat{1,cellnum}.puffTenBinsFR(testlapsuse(j),airbin); %find the fr for each neuron/
                  if isnan(testmat(j+numtestlaps*(mbin-1),nn))
                      testmat(j+numtestlaps*(mbin-1),nn) =0;
                  end                                                                                 %test trial and put it in the matrix
              end
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
                   if testids(k)==0
                       TN = TN + 1;
                   end
                   if testids(k)==1
                       TP = TP + 1;
                   end
               
               elseif label(k) ~= testids(k)
                   if testids(k)==0
                       FP = FP + 1;
                   end
                   if testids(k)==1
                       FN = FN + 1;
                   end
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

    precision = TP/(TP+FP)
    recall=TP/(TP+FN)
    F1=2*((precision*recall)/(precision+recall))

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

%end

% plot(resultsmap);
% xlabel("Cell Numbers");
% ylabel("Average Accuracy");
% title("Accuracy VS CellNum for Airpuff");
% 
% plot(shuffled_resultsmap);
% xlabel("Cell Numbers");
% ylabel("Average Accuracy");
% title("Shuffled Accuracy VS CellNum for Airpuff");
