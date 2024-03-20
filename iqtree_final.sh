#!/bin/bash

# creates 20 trees each from CDS and peptide alignments, using seed values from 1 to 20.
# assume TIM2e+R5 model for CDS and JTTDCMut+R5 for DNA
# model suggestions were obtained when running a similar tree construction with the option "-m MF" (find best model)


iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.1 --seed 1 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.1 --seed 1 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.2 --seed 2 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.2 --seed 2 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.3 --seed 3 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.3 --seed 3 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.4 --seed 4 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.4 --seed 4 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.5 --seed 5 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.5 --seed 5 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.6 --seed 6 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.6 --seed 6 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.7 --seed 7 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.7 --seed 7 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.8 --seed 8 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.8 --seed 8 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.9 --seed 9 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.9 --seed 9 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.10 --seed 10 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.10 --seed 10 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.11 --seed 11 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.11 --seed 11 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.12 --seed 12 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.12 --seed 12 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.13 --seed 13 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.13 --seed 13 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.14 --seed 14 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.14 --seed 14 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.15 --seed 15 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.15 --seed 15 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.16 --seed 16 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.16 --seed 16 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.17 --seed 17 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.17 --seed 17 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.18 --seed 18 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.18 --seed 18 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.19 --seed 19 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.19 --seed 19 -ntop 100 -ninit 1000

iqtree2 -T 6 -s 152_CDS_full_correct.mafft.trimal_gt09.fa -m TIM2e+R5 -B 10000 --boot-trees --prefix iqtree.CDS.20 --seed 20 -ntop 100 -ninit 1000
iqtree2 -T 6 -s 152_pepseq.MUSCLE.trimal_gt09.fa -m JTTDCMut+R5 -B 10000 --boot-trees --prefix iqtree.pep.20 --seed 20 -ntop 100 -ninit 1000
