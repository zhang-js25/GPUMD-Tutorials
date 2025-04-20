#!/bin/bash

touch run.in
cat > run.in <<EOF
#fatigue
potential       UNEP-v1-model-with-ZBL.txt
velocity        300
time_step       2

#(0)output the 1st frame
ensemble        nve
dump_thermo     1
dump_exyz       1 0 0
time_step       0
run             1

#(1)relax
ensemble        npt_scr 300 300 100 0 100 1000
dump_thermo     100000
dump_exyz       100000 0 0
time_step       2
run             100000
EOF
echo "                                          "                        >> run.in
echo "#(2)fatigue (lx=64A, MaxSigma=6%, StrainRate=1e9) "               >> run.in
for((k=1;k<=50;k++));do
    echo "#cycle ${k} "                                                  >> run.in
    echo "ensemble        npt_scr 300 300 100 0 0 0 100 100 100 1000"    >> run.in
    echo "deform          0.000128 1 0 0"                               >> run.in
    echo "dump_thermo     1000"                                          >> run.in
    echo "dump_exyz       20000 0 0"                                     >> run.in
    echo "run             20000"                                         >> run.in
    echo "ensemble        npt_scr 300 300 100 0 0 0 100 100 100 1000"    >> run.in
    echo "deform          -0.000128 1 0 0"                               >> run.in
    echo "dump_thermo     1000"                                          >> run.in
    echo "dump_exyz       20000 0 0"                                     >> run.in
    echo "run             20000"                                         >> run.in
    echo "ensemble        npt_scr 300 300 100 0 0 0 100 100 100 1000"    >> run.in
    echo "deform          -0.000128 1 0 0"                               >> run.in
    echo "dump_thermo     1000"                                          >> run.in
    echo "dump_exyz       20000 0 0"                                     >> run.in
    echo "run             20000"                                         >> run.in
    echo "ensemble        npt_scr 300 300 100 0 0 0 100 100 100 1000"    >> run.in
    echo "deform          0.000128 1 0 0"                                >> run.in
    echo "dump_thermo     1000"                                          >> run.in
    echo "dump_exyz       20000 0 0"                                     >> run.in
    echo "run             20000"                                         >> run.in
done
