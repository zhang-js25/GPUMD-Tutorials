
***************************************************************
*                 Welcome to use GPUMD                        *
*     (Graphics Processing Units Molecular Dynamics)          *
*                     Version 3.5                             *
*              This is the gpumd executable                   *
***************************************************************


---------------------------------------------------------------
Compiling options:
---------------------------------------------------------------

DEBUG is off: Use different PRNG seeds for different runs.

---------------------------------------------------------------
GPU information:
---------------------------------------------------------------

number of GPUs = 1
Device id:                   0
    Device name:             NVIDIA GeForce RTX 3080 Ti
    Compute capability:      8.6
    Amount of global memory: 11.7682 GB
    Number of SMs:           80

---------------------------------------------------------------
Started running GPUMD.
---------------------------------------------------------------


---------------------------------------------------------------
Started initializing positions and related parameters.
---------------------------------------------------------------

Number of atoms is 16900.
Use periodic boundary conditions along x.
Use periodic boundary conditions along y.
Use periodic boundary conditions along z.
Use orthogonal box.
Box lengths are
    Lx =     4.8100000000e+01 A
    Ly =     4.8100000000e+01 A
    Lz =     9.2500000000e+01 A
Do not specify initial velocities here.
Have 1 grouping method(s).
There are 2 groups of atoms in grouping method 0.
    8450 atoms in group 0.
    8450 atoms in group 1.
There are 4 atom types.
    0 atoms of type 0.
    16900 atoms of type 1.
    0 atoms of type 2.
    0 atoms of type 3.

---------------------------------------------------------------
Finished initializing positions and related parameters.
---------------------------------------------------------------


---------------------------------------------------------------
Started executing the commands in run.in.
---------------------------------------------------------------

Use the NEP4 potential with 4 atom types.
    type 0 (Pd with Z = 46).
    type 1 (Cu with Z = 29).
    type 2 (Ni with Z = 28).
    type 3 (P with Z = 15).
    has ZBL with inner cutoff 0.9 A and outer cutoff 1.8 A.
    radial cutoff = 6 A.
    angular cutoff = 4 A.
    MN_radial = 127.
    MN_angular = 42.
    enlarged MN_radial = 159.
    enlarged MN_angular = 53.
    n_max_radial = 8.
    n_max_angular = 8.
    basis_size_radial = 8.
    basis_size_angular = 8.
    l_max_3body = 4.
    l_max_4body = 2.
    l_max_5body = 0.
    ANN = 54-50-1.
    number of neural network parameters = 11201.
    number of descriptor parameters = 2592.
    total number of parameters = 13793
Initialized velocities with T = 300 K.
Time step for this run is 1 fs.
Use NPT ensemble for this run.
    choose the SCR method.
    initial temperature is 300 K.
    final temperature is 300 K.
    tau_T is 100 time_step.
    isotropic pressure is 0 GPa.
    bulk modulus is 200 GPa.
    tau_p is 1000 time_step.
Group 1 in grouping method 0 will be fixed.
Dump thermo every 1000 steps.
Dump extended XYZ.
    every 100000 steps.
    without velocity data.
    without force data.
Dump restart every 100000 steps.

---------------------------------------------------------------
Warning: Starting from GPUMD-v3.4, the velocity data in restart.xyz will be in units of Angstrom/fs
         Previously they are in units of 1/1.018051e+1 Angstrom/fs.
---------------------------------------------------------------

Run 1000000 steps.
    100000 steps completed.
    200000 steps completed.
    300000 steps completed.
    400000 steps completed.
    500000 steps completed.
    600000 steps completed.
    700000 steps completed.
    800000 steps completed.
    900000 steps completed.
    1000000 steps completed.

---------------------------------------------------------------
Time used for this run = 3303.56 second.
Speed of this run = 5.11569e+06 atom*step/second.
---------------------------------------------------------------

Use NPT ensemble for this run.
    choose the SCR method.
    initial temperature is 1800 K.
    final temperature is 1800 K.
    tau_T is 100 time_step.
    isotropic pressure is 0 GPa.
    bulk modulus is 200 GPa.
    tau_p is 1000 time_step.
Group 0 in grouping method 0 will be fixed.
Dump thermo every 1000 steps.
Dump extended XYZ.
    every 100000 steps.
    without velocity data.
    without force data.
Dump restart every 100000 steps.

---------------------------------------------------------------
Warning: Starting from GPUMD-v3.4, the velocity data in restart.xyz will be in units of Angstrom/fs
         Previously they are in units of 1/1.018051e+1 Angstrom/fs.
---------------------------------------------------------------

Run 1000000 steps.
    100000 steps completed.
    200000 steps completed.
    300000 steps completed.
    400000 steps completed.
    500000 steps completed.
    600000 steps completed.
    700000 steps completed.
    800000 steps completed.
    900000 steps completed.
    1000000 steps completed.

---------------------------------------------------------------
Time used for this run = 3355.22 second.
Speed of this run = 5.03693e+06 atom*step/second.
---------------------------------------------------------------


---------------------------------------------------------------
Finished executing the commands in run.in.
---------------------------------------------------------------


---------------------------------------------------------------
Time used = 6658.815392 s.
---------------------------------------------------------------


---------------------------------------------------------------
Finished running GPUMD.
---------------------------------------------------------------

