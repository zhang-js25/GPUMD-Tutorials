#!/bin/bash
in='OUT'
out='poly.xyz'
mkdir ${out}
cd ${in}
for f in `ls` ; do
    ase convert -i lammps-dump-text -o extxyz ${f} ../${out}/${f}.xyz
done
