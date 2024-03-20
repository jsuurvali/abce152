#!/bin/bash

# prepare a CDS alignment for tree construction
mafft '152 CDS FULL_correct.fas' > 152_CDS_full_correct_aligned.fa  # align the file containing CDS sequences
trimal -in 152_CDS_full_correct_aligned.fa -out 152_CDS_full_correct.mafft.trimal_gt09.fa -gt 0.9 # remove sites with more than 10% missing data


# prepare a protein alignment for tree construction
sed 's/ /_/' 152_pepseq_MUSCLE.fa > 152_pepseq_MUSCLE_v2.fa # reformat sequence names in the MUSCLE alignment from MEGA to match names in the CDS alignment
trimal -in 152_pepseq_MUSCLE_v2.fa -out 152_pepseq.MUSCLE.trimal_gt09.fa -gt 0.9 #  remove sites with more than 10% missing data
