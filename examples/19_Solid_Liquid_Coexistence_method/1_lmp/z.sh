#!/bin/sh
#SBATCH -J zr
#SBATCH -N 1
#SBATCH --ntasks-per-node=40
####SBTACH -gres=gpu:1

#ulimit -s unlimited
#export CUDA_VISIBLE_DEVICES=0

mpirun -np 8 lmp_oneapi -in in.txt
