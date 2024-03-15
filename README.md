# Global-Ancestry-Assignment
This approach involves first running the principal component analysis (PCA) on all 1000 Genomes samples using a set of high-quality, autosomal, bi-allelic, and LD-pruned single nucleotide variants (SNVs). The target samples are then projected onto these principal components (PCs). As the super population/ancestry information is available for 1000 Genomes samples, it is used to train a random forest classifier using the PCs as features. This trained model is then used to predict the ancestry of the target samples.

## 1. PCA analysis using GCTA
sh script/GCTA_PCAanalysis.sh

## 2. Global ancestry ineference using Random Forest Classifier
Rscript script/AncestryInference.R


Cite the code: [![DOI](https://zenodo.org/badge/617596047.svg)](https://zenodo.org/doi/10.5281/zenodo.10820994)
