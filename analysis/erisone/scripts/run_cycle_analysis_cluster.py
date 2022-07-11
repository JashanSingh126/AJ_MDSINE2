'''Run keystoneness given the chain.
'''

lsfstr = '''#!/bin/bash
#BSUB -J {jobname}
#BSUB -o {stdout_loc}
#BSUB -e {stderr_loc}

#BSUB -q {queue}
#BSUB -n {cpus}
#BSUB -M {mem}
#BSUB -R rusage[mem={mem}]

# 
echo '---PROCESS RESOURCE LIMITS---'
ulimit -a
echo '---SHARED LIBRARY PATH---'
echo $LD_LIBRARY_PATH
echo '---APPLICATION SEARCH PATH:---'
echo $PATH
echo '---LSF Parameters:---'
printenv | grep '^LSF'
echo '---LSB Parameters:---'
printenv | grep '^LSB'
echo '---LOADED MODULES:---'
module list
echo '---SHELL:---'
echo $SHELL
echo '---HOSTNAME:---'
hostname
echo '---GROUP MEMBERSHIP (files are created in the first group listed):---'
groups
echo '---DEFAULT FILE PERMISSIONS (UMASK):---'
umask
echo '---CURRENT WORKING DIRECTORY:---'
pwd
echo '---DISK SPACE QUOTA---'
df .
echo '---TEMPORARY SCRATCH FOLDER ($TMPDIR):---'
echo $TMPDIR


# Load the environment
module load anaconda/4.8.2
source activate {environment_name}
cd {code_basepath}

{cmd}
'''

cycle_command='''
python analysis/helpers/cycle_count_cluster.py \
    --mcmc_path {chain} \
    --out_dir {outdir} \
    --max_path_len {pathlen}
'''

chain_command='''
python analysis/helpers/cycle_count_cluster.py \
    --mcmc_path {chain} \
    --out_dir {outdir} \
    --max_path_len {pathlen} \
    --do_chains
'''

import mdsine2 as md2
import argparse
import os

if __name__ == '__main__':
    parser = argparse.ArgumentParser(usage=__doc__)
    parser.add_argument('--jobname', type=str, required=True)
    parser.add_argument('--chain', type=str, required=True)
    parser.add_argument('--outdir', type=str, required=True)
    parser.add_argument('--path_len', type=int, default=4, required=False)

    # ErisOne parameters
    parser.add_argument('--environment-name', dest='environment_name', type=str,
        help='Name of the conda environment to activate when the job starts')
    parser.add_argument('--code-basepath', type=str, dest='code_basepath',
        help='Where the `run_cross_validation` script is located')
    parser.add_argument('--queue', '-q', type=str, dest='queue',
        help='ErisOne queue this job gets submitted to')
    parser.add_argument('--memory', '-mem', type=str, dest='memory',
        help='Amount of memory to reserve on ErisOne')
    parser.add_argument('--n-cpus', '-cpus', type=str, dest='cpus',
        help='Number of cpus to reserve on ErisOne')
    parser.add_argument('--lsf-basepath', '-l', type=str, dest='lsf_basepath',
        help='This is the basepath to save the lsf files', default='lsf_files/')
    parser.add_argument('--do_chains', action="store_true")
    args = parser.parse_args()

    lsfdir = args.lsf_basepath
    os.makedirs(lsfdir, exist_ok=True)
    script_path = os.path.join(lsfdir, 'scripts')
    stdout_loc = os.path.join(lsfdir, 'stdout')
    stderr_loc = os.path.join(lsfdir, 'stderr')
    os.makedirs(script_path, exist_ok=True)
    os.makedirs(stdout_loc, exist_ok=True)
    os.makedirs(stderr_loc, exist_ok=True)

    jobname = args.jobname
    stdout_name = os.path.join(stdout_loc, jobname + '.out')
    stderr_name = os.path.join(stderr_loc, jobname + '.err')
    lsfname = os.path.join(script_path, jobname + '.lsf')

    if args.do_chains:
        cmd = chain_command
    else:
        cmd = cycle_command
    cmd = cmd.format(
        chain=args.chain,
        outdir=args.outdir,
        pathlen=args.path_len
    )

    f = open(lsfname, 'w')
    f.write(lsfstr.format(
        jobname=jobname, stdout_loc=stdout_name,
        stderr_loc=stderr_name, queue=args.queue,
        cpus=args.cpus, mem=args.memory,
        environment_name=args.environment_name,
        code_basepath=args.code_basepath,
        cmd=cmd
    ))
    f.close()
    command = 'bsub < {}'.format(lsfname)
    print(command)
    os.system(command)
