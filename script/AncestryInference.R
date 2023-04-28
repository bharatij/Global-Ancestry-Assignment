library(randomForest)
library(tidyverse)
library(data.table)

pc1kg = fread('Autosomes.1KG.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.Aligned.HC_SNPs.maf0.05.commonsnps.GCTA.PCA20.eigenvec', header = F)
pc1kg = pc1kg[,2:10]
colnames(pc1kg) = c('SampleId','PC1','PC2','PC3','PC4','PC5','PC6','PC7','PC8')
poplab = fread('1KG_PopulationLabels.tsv',sep = "\t", header = T, select=c('SampleId','Superpopulation'))

pc1kg = pc1kg %>% inner_join(poplab, by='SampleId')

pctarget = fread('targetSampleSet.HC_SNPs.maf0.05.commonsnps_PCA20_Using1KgPCloadings.proj.eigenvec', header = F)
pctarget = pctarget[,2:10]
colnames(pctarget) = c('SampleId','PC1','PC2','PC3','PC4','PC5','PC6','PC7','PC8')

set.seed(12320)
rf_classifier = randomForest(x = pc1kg[,2:9 ], y = as.factor(pc1kg$Superpopulation), ntree = 400,      keep.inbag = T, importance=TRUE)

predictions <- as.data.frame(predict(rf_classifier, pctarget[,-1], type = "prob"))
predictions$PredictAncestry <- names(predictions)[1:5][apply(predictions[,1:5], 1, which.max)]
predictions$SampleId = pctarget$SampleId

res = predictions %>% select(SampleId, PredictAncestry) %>% inner_join(pctarget, by='SampleId') %>%
  rename(Ancestry=2)
  
fwrite(res, file = "TargetSampleSet_PredictedAncestry.tsv", sep = "\t", quote = F, row.names = F)


