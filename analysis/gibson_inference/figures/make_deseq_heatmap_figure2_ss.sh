#!/bin/bash

set -e
source gibson_inference/settings.sh


python gibson_inference/figures/deseq_heatmap_ss.py \
    -loc "gibson_inference/figures/figure2_files" \
    -abund "high" \
    -txt "abundant_species" \
    -taxo "order" \
    -o "mat_order_high_ss" \
    -o_loc "${PLOTS_OUT_DIR}"


python gibson_inference/figures/deseq_heatmap_ss.py \
    -loc "gibson_inference/figures/figure2_files" \
    -abund "low" \
    -txt "abundant_species" \
    -taxo "order" \
    -o "mat_order_low_ss" \
    -o_loc "${PLOTS_OUT_DIR}"
