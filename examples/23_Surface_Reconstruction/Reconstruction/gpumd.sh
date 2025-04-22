#!/bin/bash 

# Please modify the following based on your HPC task scheduling system

#SBATCH -J Reconstruction
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --gres=gpu:RTX4090:1
#SBATCH -p gpu

module use /public/home/cqian/easybuild/modules/all
module load GPUMD/3.9.4-NVHPC-23.7-CUDA-12.1.1-all
gpumd
