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
# variables
#NEPfile='nep.txt'
#elm=('Pd' 'Cu' 'Ni' 'P' 'PdCuNiP' 'PdNiP')
#run1=1000000  ; every1=1000 ; every2=10000 ; every3=100000
NEPfile='nep.txt'
elm=('Pd' 'Cu' 'Ni' 'P')
run1=500000 ; every1=1000 ; every2=10000 ; every3=100000
#--------------------------------------------------------------
mkdir 2MP 
cd 2MP
#--------------------------------------------------------------
#loop elements and temperature
for e in ${elm[*]} ; do
    mkdir ${e} ; cd ${e}
    #set T1, T2, Tm
    if [ ${e} == 'Pd' ] ; then
	Tm=('1400' '1450' '1470' '1480' '1490' '1500' '1510' '1520' '1600')
    elif [ ${e} == 'Cu' ] ; then
	Tm=('1100' '1200' '1210' '1220' '1230' '1240' '1250' '1300' '1400')
    elif [ ${e} == 'Ni' ] ; then
	Tm=('1400' '1500' '1550' '1560' '1570' '1580' '1590' '1600' '1610' '1700')
    elif [ ${e} == 'P' ] ; then 
	Tm=('250'  '300'  '350'  '400'  '450')
    else
	continue
    fi
for T in ${Tm[*]} ; do
    mkdir ${T} ; cd ${T}

#get model.xyz
cp ../../../0bak/restart.${e}.xyz model.xyz

#get run.in
touch run.in
cat > run.in <<EOF
# ${e} MeltingPoint
# (Tm: Pd=1828.1K, Cu=1357.8K, Ni=1728.0K, P=317.3K.)

potential       ../../../0bak/${NEPfile}
velocity        ${T}
time_step       1

#relax T
ensemble        npt_scr ${T} ${T} 100 0 200 1000
dump_thermo     ${every1}
dump_exyz       ${every3} 0 0
dump_restart    ${every3}
run             ${run1}
EOF
#dos2unix
dos2unix run.in model.xyz
#run gpumd
gpumd | tee -a log.${e}
#post-processing
# For a given temperature, the potential energy corresponding to 
# that temperature is calculated as the average of the potential 
# energy values extracted from the last 1/10 of the steps in the 
# thermo.out output file. By default, these steps are assumed to 
# represent the system in equilibrium.
nrows0=`cat thermo.out | wc -l`
nrows=$(( ${nrows0} / 10 ))
tail -n ${nrows} thermo.out > tmp.txt
ave1=`awk '{sum+=$3} END {print sum/NR}' tmp.txt`
atoms=`head -n 1 model.xyz`
ave=`echo "${ave1} ${atoms}" | awk '{printf($1/$2)}'`
echo "${T}  ${ave}" >> ../../PEvsT.${e}.txt
#back to upper level directory
cd ..
done
cd ..
done
#--------------------------------------------------------------

