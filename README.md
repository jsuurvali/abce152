# Plant ABCE genes and their copy numbers
This repository covers phylogenetic and regression analysis of 152 ABCE proteins from 76 plant species. It is part of a study currently available at [bioRxiv](https://doi.org/10.1101/2023.09.29.560150).

In addition to the analysis scripts themselves, source data used for the paper (alignments and annotations) and output trees are also included.

## Source data
- fasta/152 CDS FULL_correct.fas
  - unaligned CDS sequences
- fasta/152_pepseq_MUSCLE.fa
  - protein sequences, pre-aligned with MUSCLE
- ABCE_infosheet.tsv
  - genome parameters and NCBI taxID for each species in the study
- annotation_v2.tsv
  - annotations for each sequence used to construct phylogenies. Can be loaded into FigTree with the output trees from phylogenetic analysis


## Analysis scripts
- prepare_alignments.sh
  - aligns CDS sequences with [mafft](https://mafft.cbrc.jp/).
  - Uses [trimal](https://github.com/inab/trimal/) to exclude sites with > 10% gaps
- abce_iqtree.sh
  - creates sets of 20 CDS trees and 20 protein (pep) trees by running [IQ-TREE](http://www.iqtree.org/) with random seed values from 1 to 20 and otherwise identical parameters.
- abce_models_needskey.R
  - R script that was used to perform regression analyses and plot the output.
  - Requires the libraries [tidyverse](https://www.tidyverse.org/), [ggeffects](https://strengejacke.github.io/ggeffects/), [patchwork](https://patchwork.data-imaginist.com/), [nlme](https://cran.r-project.org/web/packages/nlme/index.html), [taxize](https://docs.ropensci.org/taxize/) and [ape](https://cran.r-project.org/web/packages/ape/index.html).
  - Also requires the user's [NCBI API key](https://support.nlm.nih.gov/knowledgebase/article/KA-05317/) in order to fetch taxonomic relationships.


## Output trees
- trees/CDStrees.originals.seed1-seed20.nwk and trees/peptrees.originals.seed1-seed20.nwk
  - Newick-formatted output trees from running abce_iqtree.sh, concatenated into two files with 20 trees in them (one for proteins, one for CDS). Trees are in the order of seed values used (1-20).
  - Note that in [Figtree](http://tree.bio.ed.ac.uk/software/figtree/) the trees can be supplemented with annotations from the file annotation_v2.tsv 
- trees/CDStrees.modified.figtree.nex and trees/peptrees.modified.figtree.nex
  - Same 20+20 independently obtained trees, but saved with annotations as Figtree-openable .nex files, with the following modifications:
    - Trees are in the order of their associated likelihood values (highest to lowest)
    - All trees are rooted on the phylum _Chlorophyta_.
    - Branches supported by less than 50% of bootstrap replicates are collapsed.
    - Major phylogenetic clades are highlighted as on figures of the manuscript.

## Software versions used for the manuscript
  - [mafft](https://mafft.cbrc.jp/): 7.490
  - [trimal](https://github.com/inab/trimal/): 1.4.rev22
  - [IQ-TREE](http://www.iqtree.org/): 2.0.7
  - [Figtree](http://tree.bio.ed.ac.uk/software/figtree/): 1.4.3
  - [R](https://cran.r-project.org/): 4.3.2
  - [tidyverse](https://www.tidyverse.org/): 2.0.0
  - [ggeffects](https://strengejacke.github.io/ggeffects/): 1.3.4
  - [patchwork](https://patchwork.data-imaginist.com/): 1.2.0
  - [nlme](https://cran.r-project.org/web/packages/nlme/index.html): 3.1-164
  - [taxize](https://docs.ropensci.org/taxize/): 0.9.100
  - [ape](https://cran.r-project.org/web/packages/ape/index.html): 5.7-1 
