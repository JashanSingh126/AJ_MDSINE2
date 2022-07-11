#!/bin/bash

# ErisOne parameters
# ------------------
# Path to MDSINE2_Paper code
MDSINE2_PAPER_CODE_PATH=${MDSINE2_PAPER_CODE_PATH:-"/data/cctm/darpa_perturbation_mouse_study/MDSINE2_Paper"}
# Conda environment
ENVIRONMENT_NAME="mdsine2"
# Queues, memory, and numpy of cpus
QUEUE="short"
MEM="4000"
N_CPUS="1"
LSF_BASEPATH="lsf_files/keystoneness"

# Forward simulation parameters
# -----------------------------
SIM_DT="0.01"
N_DAYS="60"
OUTPUT_BASEPATH="output/keystoneness"
SEP=","

TABLE_BASEPATH="output/keystoneness/tables"
CLUSTER_BASEPATH="../output/keystoneness/clusters"
TAXA_BASEPATH="../output/keystoneness/taxa"

HEALTHY_CHAIN="output/mdsine2/healthy-seed0/mcmc.pkl"
UC_CHAIN="output/mdsine2/uc-seed0/mcmc.pkl"

HEALTHY_STUDY="output/mdsine2/healthy-seed0/subjset.pkl"
UC_STUDY="output/mdsine2/uc-seed0/subjset.pkl"


# Make the tables
# ---------------
echo "Make the tables"

python scripts/make_leave_out_tables.py \
    --chain ../../output/mdsine2/healthy-seed0/mcmc.pkl \
    --output-basepath "../../${TABLE_BASEPATH}" \
    --sep $SEP
python scripts/make_leave_out_tables.py \
    --chain ../../output/mdsine2/healthy-seed1/mcmc.pkl \
    --output-basepath "../../${TABLE_BASEPATH}" \
    --sep $SEP
python scripts/make_leave_out_tables.py \
    --chain ../../output/mdsine2/uc-seed0/mcmc.pkl \
    --output-basepath "../../${TABLE_BASEPATH}" \
    --sep $SEP
python scripts/make_leave_out_tables.py \
    --chain ../../output/mdsine2/uc-seed1/mcmc.pkl \
    --output-basepath "../../${TABLE_BASEPATH}" \
    --sep $SEP

# Compute keystoneness
# --------------------
python scripts/run_keystoneness.py \
    --chain $HEALTHY_CHAIN \
    --study $HEALTHY_STUDY \
    --simulation-dt $SIM_DT \
    --n-days$N_DAYS  \
    --output-basepath $TAXA_BASEPATH \
    --leave-out-table "${TABLE_BASEPATH}/healthy-seed0-taxa.csv" \
    --sep $SEP \
    --environment-name $ENVIRONMENT_NAME \
    --code-basepath $MDSINE2_PAPER_CODE_PATH \
    --queue $QUEUE \
    --memory $MEM \
    --n-cpus $N_CPUS \
    --lsf-basepath $LSF_BASEPATH

python scripts/run_keystoneness.py \
    --chain $HEALTHY_CHAIN \
    --study $HEALTHY_STUDY \
    --simulation-dt $SIM_DT \
    --n-days$N_DAYS  \
    --output-basepath $CLUSTER_BASEPATH \
    --leave-out-table "${TABLE_BASEPATH}/healthy-seed0-clusters.csv" \
    --sep $SEP \
    --environment-name $ENVIRONMENT_NAME \
    --code-basepath $MDSINE2_PAPER_CODE_PATH \
    --queue $QUEUE \
    --memory $MEM \
    --n-cpus $N_CPUS \
    --lsf-basepath $LSF_BASEPATH

python scripts/run_keystoneness.py \
    --chain $UC_CHAIN \
    --study $UC_STUDY \
    --simulation-dt $SIM_DT \
    --n-days$N_DAYS  \
    --output-basepath $TAXA_BASEPATH \
    --leave-out-table "${TABLE_BASEPATH}/uc-seed0-taxa.csv" \
    --sep $SEP \
    --environment-name $ENVIRONMENT_NAME \
    --code-basepath $MDSINE2_PAPER_CODE_PATH \
    --queue $QUEUE \
    --memory $MEM \
    --n-cpus $N_CPUS \
    --lsf-basepath $LSF_BASEPATH

python scripts/run_keystoneness.py \
    --chain $UC_CHAIN \
    --study $UC_STUDY \
    --simulation-dt $SIM_DT \
    --n-days$N_DAYS  \
    --output-basepath $CLUSTER_BASEPATH \
    --leave-out-table "${TABLE_BASEPATH}/uc-seed0-clusters.csv" \
    --sep $SEP \
    --environment-name $ENVIRONMENT_NAME \
    --code-basepath $MDSINE2_PAPER_CODE_PATH \
    --queue $QUEUE \
    --memory $MEM \
    --n-cpus $N_CPUS \
    --lsf-basepath $LSF_BASEPATH