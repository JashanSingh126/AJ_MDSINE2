#!/bin/bash

echo "Performing consistency filtering over Study objects"

# Filter the OTUs using consistency filtering
python ../../step_2_filtering.py \
    --dataset ../../output/debug/processed_data/gibson_healthy_agg_taxa.pkl \
    --outfile ../../output/debug/processed_data/gibson_healthy_agg_taxa_filtered.pkl \
    --dtype rel \
    --threshold 0.0001 \
    --min-num-consecutive 7 \
    --min-num-subjects 2 \
    --colonization-time 5 \
    --max-n-otus 15
python ../../step_2_filtering.py \
    --dataset ../../output/debug/processed_data/gibson_uc_agg_taxa.pkl \
    --outfile ../../output/debug/processed_data/gibson_uc_agg_taxa_filtered.pkl \
    --dtype rel \
    --threshold 0.0001 \
    --min-num-consecutive 7 \
    --min-num-subjects 2 \
    --colonization-time 5 \
    --max-n-otus 15

# Learn negative binomial dispersion parameters
python ../scripts/filter_replicates_like_other_dataset.py \
    --replicate-dataset ../../output/debug/processed_data/gibson_replicates_agg_taxa.pkl \
    --like-other ../../output/debug/processed_data/gibson_healthy_agg_taxa_filtered.pkl \
    --output-basepath ../../output/debug/processed_data/gibson_replicates_agg_taxa_filtered.pkl
