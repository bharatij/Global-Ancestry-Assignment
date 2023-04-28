#!/bin/bash

gcta64 --bfile Autosomes.1KG.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.Aligned.HC_SNPs.maf0.05.commonsnps \
       --autosome \
       --make-grm  \
       --out Autosomes.1KG.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.Aligned.HC_SNPs.maf0.05.commonsnps.GCTA
       
echo "Calculate 20 PCs for 1000 genomes data .....";
gcta64 --grm Autosomes.1KG.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.Aligned.HC_SNPs.maf0.05.commonsnps.GCTA \
       --pca 20 \
       --out Autosomes.1KG.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.Aligned.HC_SNPs.maf0.05.commonsnps.GCTA.PCA20
       
echo "use the PCs generated above in 1000 genomes data to produce PC loadings of each SNP .....";
gcta64 --bfile Autosomes.1KG.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.Aligned.HC_SNPs.maf0.05.commonsnps \
       --pc-loading Autosomes.1KG.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.Aligned.HC_SNPs.maf0.05.commonsnps.GCTA.PCA20 \
       --out Autosomes.1KG.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.Aligned.HC_SNPs.maf0.05.commonsnps.GCTA.PCA20.snp_loading
    
echo "Compute the PCs of the target samples using the PC loading generated above .....";
gcta64 --bfile targetSampleSet.HC_SNPs.maf0.05.commonsnps \
       --project-loading Autosomes.1KG.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.Aligned.HC_SNPs.maf0.05.commonsnps.GCTA.PCA20.snp_loading 20 \
       --out targetSampleSet.HC_SNPs.maf0.05.commonsnps_PCA20_Using1KgPCloadings
