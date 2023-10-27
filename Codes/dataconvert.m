bla_airpuff=load("bla_airpuff.mat").results;
bla_shuffled=load("bla_shuffled.mat").shuffled_result;
nb_bla_airpuff=load("NB_bla_results.mat").results;
nb_bla_shuffled=load("NB_bla_shuffled.mat").shuffled_result;

cen_airpuff=load("cen_airpuff.mat").results;
cen_shuffled=load("cen_shuffled.mat").shuffled_result;
nb_cen_airpuff=load("NB_cen_results.mat").results;
nb_cen_shuffled=load("NB_cen_shuffled.mat").shuffled_result;

hpc_airpuff=load("hpc_airpuff.mat").results;
hpc_shuffled=load("hpc_shuffled.mat").shuffled_result;
nb_hpc_airpuff=load("NB_hpc_results.mat").results;
nb_hpc_shuffled=load("NB_hpc_shuffled.mat").shuffled_result;

pir_airpuff=load("pir_airpuff.mat").results;
pir_shuffled=load("pir_shuffled.mat").shuffled_result;
nb_pir_airpuff=load("NB_pir_results.mat").results;
nb_pir_shuffled=load("NB_pir_shuffled.mat").shuffled_result;

mid_airpuff=load("mid_airpuff_data.mat").results;
mid_shuffled=load("mid_airpuff_shuffled.mat").shuffled_result;
nb_airpuff=load("NB_results.mat").results;
nb_shuffled=load("NB_shuffled_results.mat").shuffled_result;

puffdata2=vertcat(bla_airpuff',bla_shuffled',nb_bla_airpuff',nb_bla_shuffled', cen_airpuff',cen_shuffled',nb_cen_airpuff', nb_cen_shuffled', hpc_airpuff',hpc_shuffled', nb_hpc_airpuff',nb_hpc_shuffled', pir_airpuff',pir_shuffled', nb_pir_airpuff', nb_pir_shuffled', mid_airpuff',mid_shuffled', nb_airpuff', nb_shuffled');

vpuffdara=cell(2,10)
vpuffdara{1,1}=bla_airpuff;
vpuffdara{2,1}=bla_shuffled;
vpuffdara{1,2}=nb_bla_airpuff;
vpuffdara{2,2}=nb_bla_shuffled;
vpuffdara{1,3}=cen_airpuff;
vpuffdara{2,3}=cen_shuffled;
vpuffdara{1,4}=nb_cen_airpuff;
vpuffdara{2,4}=nb_cen_shuffled;
vpuffdara{1,5}=hpc_airpuff;
vpuffdara{2,5}=hpc_shuffled;
vpuffdara{1,6}=nb_hpc_airpuff;
vpuffdara{2,6}=nb_hpc_shuffled;
vpuffdara{1,7}=pir_airpuff;
vpuffdara{2,7}=pir_shuffled;
vpuffdara{1,8}=nb_pir_airpuff;
vpuffdara{2,8}=nb_pir_shuffled;
vpuffdara{1,9}=mid_airpuff;
vpuffdara{2,9}=mid_shuffled;
vpuffdara{1,10}=nb_airpuff;
vpuffdara{2,10}=nb_shuffled;

groupedpuff=cell(1,5)
groupedpuff{1}=[bla_airpuff,bla_shuffled,nb_bla_airpuff,nb_bla_shuffled]
groupedpuff{2}=[cen_airpuff,cen_shuffled,nb_cen_airpuff,nb_cen_shuffled]
groupedpuff{3}=[hpc_airpuff,hpc_shuffled,nb_hpc_airpuff,nb_hpc_shuffled]
groupedpuff{4}=[pir_airpuff,pir_shuffled,nb_pir_airpuff,nb_pir_shuffled]
groupedpuff{5}=[mid_airpuff,mid_shuffled,nb_airpuff,nb_shuffled]

%make a table with three variables(columns): Accuracy, Regions, Classifier

%Airpuff table
Airpuff=vertcat(bla_airpuff',cen_airpuff',hpc_airpuff',pir_airpuff',mid_airpuff');
Airpuff_shuffled=vertcat(bla_shuffled',cen_shuffled',hpc_shuffled',pir_shuffled',mid_shuffled')
NB=vertcat(nb_bla_airpuff',nb_cen_airpuff',nb_hpc_airpuff',nb_pir_airpuff',nb_airpuff')
NB_shuffled=vertcat(nb_bla_shuffled',nb_cen_shuffled',nb_hpc_shuffled',nb_pir_shuffled',nb_shuffled')
BLA=repmat({'BLA'}, 1000, 1);
CEN=repmat({'CEN'}, 1000, 1);
HPC=repmat({'HPC'}, 1000, 1);
PIR=repmat({'PIR'}, 1000, 1);
ALL=repmat({'ALL'}, 1000, 1);
loop=vertcat(BLA,CEN,HPC,PIR,ALL);
Regions=vertcat(loop,loop,loop,loop);

lda=repmat({'LDA'}, 5000, 1);
lda_shuffled=repmat({'LDA_shuffled'}, 5000, 1);
nb=repmat({'NB'}, 5000, 1);
nb_shuffled=repmat({'NB_shuffled'}, 5000, 1);
Classifier=vertcat(lda,lda_shuffled,nb,nb_shuffled);
Accuracy=vertcat(Airpuff,Airpuff_shuffled,NB,NB_shuffled);
%Airpuff_table=table(Airpuff,Airpuff_shuffled,NB,NB_shuffled,Groups)
Airpuff_table=table(Accuracy,Regions,Classifier);
writetable(Airpuff_table, 'Airpuff.csv');


%Table for bin data
Bin=vertcat(bla_bin',cen_bin',hpc_bin',pir_bin',mid_bin');
Bin_Shuffled=vertcat(bla_bin_shuffled',cen_bin_shuffled',hpc_bin_shuffled',pir_bin_shuffled',mid_bin_shuffled');
Bin_NB=vertcat(NB_bla_bin',NB_cen_bin',NB_hpc_bin',NB_pir_bin',NB_mid_bin');
Bin_NB_shuffled=vertcat(NB_bla_bin_shuffled',NB_cen_bin_shuffled',NB_hpc_bin_shuffled',NB_pir_bin_shuffled',NB_mid_bin_shuffled');
Accuracy=vertcat(Bin,Bin_Shuffled,Bin_NB,Bin_NB_shuffled);
Bin_table=table(Accuracy,Regions,Classifier);
writetable(Bin_table, 'Bins.csv');
% Define group names
groupNames = {'BLA', 'CEN', 'HPC', 'PIR', 'ALL'};

% Define data for each group (4 attributes for each group)
BLA = [bla_airpuff,bla_shuffled,nb_bla_airpuff,nb_bla_shuffled];
CEN = [cen_airpuff,cen_shuffled,nb_cen_airpuff,nb_cen_shuffled];
HPC = [hpc_airpuff,hpc_shuffled,nb_hpc_airpuff,nb_hpc_shuffled];
PIR = [pir_airpuff,pir_shuffled,nb_pir_airpuff,nb_pir_shuffled];
ALL = [mid_airpuff,mid_shuffled,nb_airpuff,nb_shuffled];

save('python_puff.mat', 'groupNames', 'BLA', 'CEN','HPC','PIR','ALL');

% [h,p] = ttest2(cen_airpuff, pir_airpuff)
% 
% 


% bla_bin=load("bla_bins.mat").results;
% bla_bin_shuffled=load("bla_bins_shuffled.mat").shuffled_result;
% 
% cen_bin=load("cen_bins.mat").results;
% cen_bin_shuffled=load("cen_bins_shuffled.mat").shuffled_result;
% 
% hpc_bin=load("hpc_bins.mat").results;
% hpc_bin_shuffled=load("hpc_bins_shuffled.mat").shuffled_result;
% 
% pir_bin=load("pir_bins.mat").results;
% pir_bin_shuffled=load("pir_bins_shuffled.mat").shuffled_result;
% 
% mid_bin=load("midbins_data.mat").results;
% mid_bin_shuffled=load("midbins_shuffled.mat").shuffled_result;
% 
% bindata=vertcat(bla_bin',bla_bin_shuffled',cen_bin',cen_bin_shuffled',hpc_bin',hpc_bin_shuffled',pir_bin',pir_bin_shuffled',mid_bin',mid_bin_shuffled');


bla_bin=load("LDA_bins_bla2.mat").results;
bla_bin_shuffled=load("LDA_bins_bla2_shuffled.mat").shuffled_result;
NB_bla_bin=load("NB_bins_bla.mat").results;
NB_bla_bin_shuffled=load("NB_bins_bla_shuffled.mat").shuffled_result;

cen_bin=load("LDA_bins_cen2.mat").results;
cen_bin_shuffled=load("LDA_bins_cen2_shuffled.mat").shuffled_result;
NB_cen_bin=load("NB_bins_cen.mat").results;
NB_cen_bin_shuffled=load("NB_bins_cen_shuffled.mat").shuffled_result;


hpc_bin=load("LDA_bins_hpc2.mat").results;
hpc_bin_shuffled=load("LDA_bins_hpc2_shuffled.mat").shuffled_result;
NB_hpc_bin=load("NB_bins_hpc.mat").results;
NB_hpc_bin_shuffled=load("NB_bins_hpc_shuffled.mat").shuffled_result;

pir_bin=load("LDA_bins_pir2.mat").results;
pir_bin_shuffled=load("LDA_bins_pir2_shuffled.mat").shuffled_result;
NB_pir_bin=load("NB_bins_pir.mat").results;
NB_pir_bin_shuffled=load("NB_bins_pir_shuffled.mat").shuffled_result;

mid_bin=load("LDA_bins_mid2.mat").results;
mid_bin_shuffled=load("LDA_bins_mid2_shuffled.mat").shuffled_result;
NB_mid_bin=load("NB_bins_results.mat").results;
NB_mid_bin_shuffled=load("NB_shuffled_results.mat").shuffled_result;

bindata2=vertcat(bla_bin',bla_bin_shuffled',NB_bla_bin',NB_bla_bin_shuffled', cen_bin',cen_bin_shuffled',NB_cen_bin', NB_cen_bin_shuffled', hpc_bin',hpc_bin_shuffled',NB_hpc_bin',NB_hpc_bin_shuffled',  pir_bin',pir_bin_shuffled',NB_pir_bin',NB_pir_bin_shuffled', mid_bin',mid_bin_shuffled', NB_mid_bin',NB_mid_bin_shuffled');

p_puff=[]
for i=1:2:20

    [h,p]=ttest2(puffdata2(1000*i-1000+1:1000*i,1),puffdata2(1000*i+1:1000*i+1000,1))
    p_puff(end+1)=p;
end

p_bin=[]
for i=1:2:20

    [h,p]=ttest2(bindata2(1000*i-1000+1:1000*i,1),bindata2(1000*i+1:1000*i+1000,1))
    p_bin(end+1)=p;
end