#!/bin/bash
mpirun --allow-run-as-root -np 8 lmp_mpi -in in.txt
