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