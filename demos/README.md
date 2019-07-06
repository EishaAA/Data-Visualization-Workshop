# Contents

1. [Datasets and data preprocessing](#datasets)
  * STRING dataset
2. [Plotting in Base R](#baseR)

---

<a name="datasets">
  
## Datasets

### STRING dataset
STRING is a database of known and predicted protein-protein interactions, with information available for many different organisms. In addition to being able to search for and explore the data through the web portal, the complete data is available for download: https://string-db.org/cgi/download.pl

For this demo, the protein interaction data for humans was downloaded from STRING version 11 (`9606.protein.links.detailed.v11.0.txt.gz`), along with a table of aliases used to convert the Ensembl protein IDs to the common protein name (`9606.protein.aliases.v11.0.txt.gz`). The interaction list was filtered to only include interactions with a combined experimental and database evidence score greater than 700, with the resulting processed dataset saved to `human_protein_interactions.tsv`.

See `datasets_stringdb.R` for the R script used to process the original STRING datasets.


### The Cancer Genome Anatomy (TCGA) project

https://portal.gdc.cancer.gov

For this demo, we are interested in visualizing patterns in gene expression in people with lung cancer (adenocarcenoma). To do this, we filter project characteristics by Experimental Strategy (RNAseq), Workflow Type (HTSeq - FPKM), and Access (open), Primary Site (Bronchus & Lung), and finally project (TCGA-LUAD). All the resultant files to the shopping cart.

After going to your shopping cart, there are multiple ways you can download the list of gene expression files. One such method is to download the manifest, then download all the files using the [GDC Data Transfer Tool](https://gdc.cancer.gov/access-data/gdc-data-transfer-tool). See `datasets_tcga.R` for the R script used to build the combined dataset.

---
<a name="baseR">
## Plotting in Base R
