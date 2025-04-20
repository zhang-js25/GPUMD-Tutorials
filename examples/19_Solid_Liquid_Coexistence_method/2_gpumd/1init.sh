#!/bin/bash
#SBATCH -J zr
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBTACH -gres=gpu:1
#ulimit -s unlimited
export CUDA_VISIBLE_DEVICES=0
#--------------------------------------------------------------
#  4. Melting Point (SLC = Solid Liquid Coexistence)
#     (Tm: Pd=1828.1K, Cu=1357.8K, Ni=1728.0K, P=317.3K.)
#--------------------------------------------------------------
# copy "potential and structures" to "0bak" foleder
NEPfile='nep.txt'
mkdir 0bak
cp  ../1_lmp/${NEPfile}   ./0bak
cp  ../1_lmp/model.*.xyz  ./0bak
#--------------------------------------------------------------
# variables
#NEPfile='nep.txt'
#elm=('Pd' 'Cu' 'Ni' 'P' 'PdCuNiP' 'PdNiP')
#run1=1000000 ; run2=1000000
#every1=1000 ; every2=10000 ; every3=100000
elm=('Pd' 'Cu' 'Ni' 'P')
run1=1000000 ; run2=1000000
every1=1000 ; every2=10000 ; every3=100000
#--------------------------------------------------------------
mkdir 1init
cd 1init

#relaxing SLC strcture
for e in ${elm[*]} ; do
    mkdir ${e} ; cd ${e}
    #set T1, T2
    if [ ${e} == 'Pd' ] ; then
	T1=500 ; T2=2000
    elif [ ${e} == 'Cu' ] ; then
	T1=300 ; T2=1800
    elif [ ${e} == 'Ni' ] ; then
	T1=500 ; T2=2000
    elif [ ${e} == 'P' ] ; then
	T1=250 ; T2=500
    elif [ ${e} == 'PdCuNiP' ] ; then
	T1=300 ; T2=1500
    elif [ ${e} == 'PdNiP' ] ; then
	T1=300 ; T2=1500
    else
	echo "Do nothing !"
    fi

#get model.xyz
cp ../../0bak/model.${e}.xyz model.xyz

#get run.in
touch run.in
cat > run.in <<EOF
# ${e} MeltingPoint
# (Tm: Pd=1828.1K, Cu=1357.8K, Ni=1728.0K, P=317.3K.)

potential       ../../0bak/${NEPfile}
velocity        ${T1}
time_step       1

#initial structure (relax T1)
ensemble        npt_scr ${T1} ${T1} 100 0 150 1000
fix             1
dump_thermo     ${every1}
dump_exyz       ${every3} 0 0
dump_restart    ${every3}
run             ${run1}

#initial structure (relax T2)
ensemble        npt_scr ${T2} ${T2} 100 0 150 1000
fix             0
dump_thermo     ${every1}
dump_exyz       ${every3} 0 0
dump_restart    ${every3}
run             ${run2}
EOF
#dos2unix
dos2unix run.in model.xyz
#run gpumd
gpumd | tee -a log.${e}
#post-processing
cp restart.xyz ../../0bak/restart.${e}.xyz
#--------------------------------------------------------------
cd ..
done
#--------------------------------------------------------------

