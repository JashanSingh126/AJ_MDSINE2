#!/bin/bash

# ErisOne parameters
# ------------------
# Path to MDSINE2_Paper code
MDSINE2_PAPER_CODE_PATH=${MDSINE2_PAPER_CODE_PATH:-"/data/cctm/darpa_perturbation_mouse_study/MDSINE2_Paper"}
# Conda environment
ENVIRONMENT_NAME="mdsine2"
# Queues, memory (_MEM), and nodes (_N) for forward simulation (TLA) and cross-validation (CV)
TLA_QUEUE="medium"
TLA_MEM="4000"
TLA_N="1"

CV_QUEUE="vlong"
CV_MEM="8000"
CV_N="1"


# Running parameters
# NOTE: THESE PATHS MUST BE RELATIVE TO `MDSINE2_PAPER_CODE_PATH`
CFG_NAME="qpcr_variance_inflated"
NEGBIN="output/negbin/replicates/mcmc.pkl"
SEED="0"
BURNIN="5000"
N_SAMPLES="15000"
CHECKPOINT="100"
MULTIPROCESSING="0"

PROCESSED_DATA_PATH="${MDSINE2_PAPER_CODE_PATH}/processed_data"
DSET_BASEPATH="${MDSINE2_PAPER_CODE_PATH}/processed_data/cv"
CV_BASEPATH="${MDSINE2_PAPER_CODE_PATH}/output/mdsine2/cv_${CFG_NAME}"
HEALTHY_DATASET="${PROCESSED_DATA_PATH}/gibson_healthy_agg_taxa_filtered.pkl"
HEALTHY_DATASET_CURR_PATH="${PROCESSED_DATA_PATH}/gibson_healthy_agg_taxa_filtered.pkl"
UC_DATASET="${PROCESSED_DATA_PATH}/gibson_uc_agg_taxa_filtered.pkl"
UC_DATASET_CURR_PATH="${PROCESSED_DATA_PATH}/gibson_uc_agg_taxa_filtered.pkl"
MAX_TLA="8"
INTERACTION_IND_PRIOR="weak-agnostic"
PERTURBATION_IND_PRIOR="weak-agnostic"

# Run healthy for each subject
# ----------------------------
python scripts/run_cv.py \
    --cfg_name $CFG_NAME \
    --dataset $HEALTHY_DATASET \
    --dataset-curr-path $HEALTHY_DATASET_CURR_PATH \
    --cv-basepath $CV_BASEPATH \
    --dset-basepath $DSET_BASEPATH \
    --negbin $NEGBIN \
    --seed $SEED \
    --burnin $BURNIN \
    --n-samples $N_SAMPLES \
    --checkpoint $CHECKPOINT \
    --multiprocessing $MULTIPROCESSING \
    --environment-name $ENVIRONMENT_NAME \
    --code-basepath $MDSINE2_PAPER_CODE_PATH \
    --leave-out-subject 2 \
    --max-tla $MAX_TLA \
    --cv-queue $CV_QUEUE \
    --cv-memory $CV_MEM \
    --cv-n-cpus $CV_N \
    --tla-queue $TLA_QUEUE \
    --tla-n-cpus $TLA_N \
    --tla-memory $TLA_MEM \
    --interaction-ind-prior $INTERACTION_IND_PRIOR \
    --perturbation-ind-prior $PERTURBATION_IND_PRIOR

python scripts/run_cv.py \
    --cfg_name $CFG_NAME \
    --dataset $HEALTHY_DATASET \
    --dataset-curr-path $HEALTHY_DATASET_CURR_PATH \
    --cv-basepath $CV_BASEPATH \
    --dset-basepath $DSET_BASEPATH \
    --negbin $NEGBIN \
    --seed $SEED \
    --burnin $BURNIN \
    --n-samples $N_SAMPLES \
    --checkpoint $CHECKPOINT \
    --multiprocessing $MULTIPROCESSING \
    --environment-name $ENVIRONMENT_NAME \
    --code-basepath $MDSINE2_PAPER_CODE_PATH \
    --leave-out-subject 3 \
    --max-tla $MAX_TLA \
    --cv-queue $CV_QUEUE \
    --cv-memory $CV_MEM \
    --cv-n-cpus $CV_N \
    --tla-queue $TLA_QUEUE \
    --tla-n-cpus $TLA_N \
    --tla-memory $TLA_MEM \
    --interaction-ind-prior $INTERACTION_IND_PRIOR \
    --perturbation-ind-prior $PERTURBATION_IND_PRIOR

python scripts/run_cv.py \
    --cfg_name $CFG_NAME \
    --dataset $HEALTHY_DATASET \
    --dataset-curr-path $HEALTHY_DATASET_CURR_PATH \
    --cv-basepath $CV_BASEPATH \
    --dset-basepath $DSET_BASEPATH \
    --negbin $NEGBIN \
    --seed $SEED \
    --burnin $BURNIN \
    --n-samples $N_SAMPLES \
    --checkpoint $CHECKPOINT \
    --multiprocessing $MULTIPROCESSING \
    --environment-name $ENVIRONMENT_NAME \
    --code-basepath $MDSINE2_PAPER_CODE_PATH \
    --leave-out-subject 4 \
    --max-tla $MAX_TLA \
    --cv-queue $CV_QUEUE \
    --cv-memory $CV_MEM \
    --cv-n-cpus $CV_N \
    --tla-queue $TLA_QUEUE \
    --tla-n-cpus $TLA_N \
    --tla-memory $TLA_MEM \
    --interaction-ind-prior $INTERACTION_IND_PRIOR \
    --perturbation-ind-prior $PERTURBATION_IND_PRIOR

python scripts/run_cv.py \
    --cfg_name $CFG_NAME \
    --dataset $HEALTHY_DATASET \
    --dataset-curr-path $HEALTHY_DATASET_CURR_PATH \
    --cv-basepath $CV_BASEPATH \
    --dset-basepath $DSET_BASEPATH \
    --negbin $NEGBIN \
    --seed $SEED \
    --burnin $BURNIN \
    --n-samples $N_SAMPLES \
    --checkpoint $CHECKPOINT \
    --multiprocessing $MULTIPROCESSING \
    --environment-name $ENVIRONMENT_NAME \
    --code-basepath $MDSINE2_PAPER_CODE_PATH \
    --leave-out-subject 5 \
    --max-tla $MAX_TLA \
    --cv-queue $CV_QUEUE \
    --cv-memory $CV_MEM \
    --cv-n-cpus $CV_N \
    --tla-queue $TLA_QUEUE \
    --tla-n-cpus $TLA_N \
    --tla-memory $TLA_MEM \
    --interaction-ind-prior $INTERACTION_IND_PRIOR \
    --perturbation-ind-prior $PERTURBATION_IND_PRIOR

# Run uc for each subject
# -----------------------
python scripts/run_cv.py \
    --cfg_name $CFG_NAME \
    --dataset $UC_DATASET \
    --dataset-curr-path $UC_DATASET_CURR_PATH \
    --cv-basepath $CV_BASEPATH \
    --dset-basepath $DSET_BASEPATH \
    --negbin $NEGBIN \
    --seed $SEED \
    --burnin $BURNIN \
    --n-samples $N_SAMPLES \
    --checkpoint $CHECKPOINT \
    --multiprocessing $MULTIPROCESSING \
    --environment-name $ENVIRONMENT_NAME \
    --code-basepath $MDSINE2_PAPER_CODE_PATH \
    --leave-out-subject 6 \
    --max-tla $MAX_TLA \
    --cv-queue $CV_QUEUE \
    --cv-memory $CV_MEM \
    --cv-n-cpus $CV_N \
    --tla-queue $TLA_QUEUE \
    --tla-n-cpus $TLA_N \
    --tla-memory $TLA_MEM \
    --interaction-ind-prior $INTERACTION_IND_PRIOR \
    --perturbation-ind-prior $PERTURBATION_IND_PRIOR

python scripts/run_cv.py \
    --cfg_name $CFG_NAME \
    --dataset $UC_DATASET \
    --dataset-curr-path $UC_DATASET_CURR_PATH \
    --cv-basepath $CV_BASEPATH \
    --dset-basepath $DSET_BASEPATH \
    --negbin $NEGBIN \
    --seed $SEED \
    --burnin $BURNIN \
    --n-samples $N_SAMPLES \
    --checkpoint $CHECKPOINT \
    --multiprocessing $MULTIPROCESSING \
    --environment-name $ENVIRONMENT_NAME \
    --code-basepath $MDSINE2_PAPER_CODE_PATH \
    --leave-out-subject 7 \
    --max-tla $MAX_TLA \
    --cv-queue $CV_QUEUE \
    --cv-memory $CV_MEM \
    --cv-n-cpus $CV_N \
    --tla-queue $TLA_QUEUE \
    --tla-n-cpus $TLA_N \
    --tla-memory $TLA_MEM \
    --interaction-ind-prior $INTERACTION_IND_PRIOR \
    --perturbation-ind-prior $PERTURBATION_IND_PRIOR

python scripts/run_cv.py \
    --cfg_name $CFG_NAME \
    --dataset $UC_DATASET \
    --dataset-curr-path $UC_DATASET_CURR_PATH \
    --cv-basepath $CV_BASEPATH \
    --dset-basepath $DSET_BASEPATH \
    --negbin $NEGBIN \
    --seed $SEED \
    --burnin $BURNIN \
    --n-samples $N_SAMPLES \
    --checkpoint $CHECKPOINT \
    --multiprocessing $MULTIPROCESSING \
    --environment-name $ENVIRONMENT_NAME \
    --code-basepath $MDSINE2_PAPER_CODE_PATH \
    --leave-out-subject 8 \
    --max-tla $MAX_TLA \
    --cv-queue $CV_QUEUE \
    --cv-memory $CV_MEM \
    --cv-n-cpus $CV_N \
    --tla-queue $TLA_QUEUE \
    --tla-n-cpus $TLA_N \
    --tla-memory $TLA_MEM \
    --interaction-ind-prior $INTERACTION_IND_PRIOR \
    --perturbation-ind-prior $PERTURBATION_IND_PRIOR

python scripts/run_cv.py \
    --cfg_name $CFG_NAME \
    --dataset $UC_DATASET \
    --dataset-curr-path $UC_DATASET_CURR_PATH \
    --cv-basepath $CV_BASEPATH \
    --dset-basepath $DSET_BASEPATH \
    --negbin $NEGBIN \
    --seed $SEED \
    --burnin $BURNIN \
    --n-samples $N_SAMPLES \
    --checkpoint $CHECKPOINT \
    --multiprocessing $MULTIPROCESSING \
    --environment-name $ENVIRONMENT_NAME \
    --code-basepath $MDSINE2_PAPER_CODE_PATH \
    --leave-out-subject 9 \
    --max-tla $MAX_TLA \
    --cv-queue $CV_QUEUE \
    --cv-memory $CV_MEM \
    --cv-n-cpus $CV_N \
    --tla-queue $TLA_QUEUE \
    --tla-n-cpus $TLA_N \
    --tla-memory $TLA_MEM \
    --interaction-ind-prior $INTERACTION_IND_PRIOR \
    --perturbation-ind-prior $PERTURBATION_IND_PRIOR

python scripts/run_cv.py \
    --cfg_name $CFG_NAME \
    --dataset $UC_DATASET \
    --dataset-curr-path $UC_DATASET_CURR_PATH \
    --cv-basepath $CV_BASEPATH \
    --dset-basepath $DSET_BASEPATH \
    --negbin $NEGBIN \
    --seed $SEED \
    --burnin $BURNIN \
    --n-samples $N_SAMPLES \
    --checkpoint $CHECKPOINT \
    --multiprocessing $MULTIPROCESSING \
    --environment-name $ENVIRONMENT_NAME \
    --code-basepath $MDSINE2_PAPER_CODE_PATH \
    --leave-out-subject 10 \
    --max-tla $MAX_TLA \
    --cv-queue $CV_QUEUE \
    --cv-memory $CV_MEM \
    --cv-n-cpus $CV_N \
    --tla-queue $TLA_QUEUE \
    --tla-n-cpus $TLA_N \
    --tla-memory $TLA_MEM \
    --interaction-ind-prior $INTERACTION_IND_PRIOR \
    --perturbation-ind-prior $PERTURBATION_IND_PRIOR