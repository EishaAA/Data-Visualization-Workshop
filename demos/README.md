# Contents

1. [Datasets and data preprocessing](#datasets)
  * STRING dataset
2. [Plotting in Base R](#baseR)

---

<a name="datasets">
  
## Datasets

### STRING dataset
STRING is a database of known and predicted protein-protein interactions, with information available for many different organisms. In addition to being able to search for and explore the data through the web portal, the complete data is available for download: https://string-db.org/cgi/download.pl

For this demo, the protein interaction data for humans was downloaded (9606.protein.links.detailed.v11.0.txt.gz), along with a table of aliases used to convert the Ensembl protein IDs to the common protein name (9606.protein.aliases.v11.0.txt.gz). The interaction list was filtered to only include interactions with a combined experimental and database evidence score greater than 700, with the resulting processed dataset saved to human_protein_interactions.tsv.

See datasets_stringdb.R for the R script used to process the original STRING datasets.

<a name="baseR">

---

## Plotting in Base R
