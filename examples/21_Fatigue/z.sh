#!/bin/bash
export CUDA_VISIBLE_DEVICES=0
gpumd | tee -a log.out
