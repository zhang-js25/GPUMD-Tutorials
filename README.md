# GPUMD-Tutorials
This repo contains various tutorials and examples using the [GPUMD package](https://github.com/brucefan1983/GPUMD) and related tools.

## List of examples


| folder                                     | creator       | description                                        |
| ---------------------------------------    | ------------- | ---------------------------------------------------|
| [01_Carbon_examples_for_JCP_2022_paper](examples/01_Carbon_examples_for_JCP_2022_paper)      | Penghua Ying | Some examples for Ref. [1] |
| [02_Carbon_density_of_states](examples/02_Carbon_density_of_states)                | Zheyong Fan   | Phonon density of states of graphene |
| [03_Carbon_thermal_transport_emd](examples/03_Carbon_thermal_transport_emd)            | Zheyong Fan  | Thermal transport in graphene from EMD |
| [04_Carbon_thermal_transport_nemd_and_hnemd](examples/04_Carbon_thermal_transport_nemd_and_hnemd) | Zheyong Fan  | Thermal transport in graphene from NEMD and NEMD |
| [05_Carbon_phonon_vibration_viewer](examples/05_Carbon_phonon_vibration_viewer)          | Ting Liang    | Visualizing the phonon modes in a type of diamond nanowire. |
| [06_Silicon_phonon_dispersion](examples/06_Silicon_phonon_dispersion)               | Zheyong Fan    | Phonon dispersions of silicon.  |
| [07_Silicon_thermal_expansion](examples/07_Silicon_thermal_expansion)               | Zheyong Fan      | Thermal expansion of silicon based on classical MD. |
| [08_Silicon_melt](examples/08_Silicon_melt)                            | Zheyong Fan   |  Melting point of silicon from two-phase method. |
| [09_Silicon_diffusion](examples/09_Silicon_diffusion)                      | Zheyong Fan   |  Diffusion coefficient of liquid silicon from VAC and MSD. |
| [10_Silicon_viscosity](examples/10_Silicon_viscosity)                       | Zheyong Fan   |  Viscosity of liquid silicon from Green-Kubo. |
| [11_NEP_potential_PbTe](examples/11_NEP_potential_PbTe)                      | Zheyong Fan   |  Train a NEP potential model for PbTe. |
| [12_NEP_dipole_QM7B](examples/12_NEP_dipole_QM7B)                         | Nan Xu        |  Train a NEP dipole model for QM7B database. |
| [13_NEP_polarizability_QM7B](examples/13_NEP_polarizability_QM7B)                 | Nan Xu        | Train a NEP polarizability model for QM7B database. |
| [14_DP](examples/14_DP)                                      | Ke Xu         |  Examples demonstrating the use of DP models in GPUMD. |
| [15_Infrared](examples/5_Infrared)                                | Nan Xu        |  Calculating infrared spectrum using dipole autocorrelation function. |
| [16_Deposition](examples/16_Deposition)                              | Shiyun Xiong  |  Creation of amorphous Si structures through atom deposition. |
| [17_Wavepacket](examples/17_Wavepacket)                              | Xin Wu        |  Phonon wavepacket simulation. |
| [18_FCP_check_force](examples/18_FCP_check_force)        | Zheyong Fan        |  Demonstration of the usage of the force constant potential (FCP) |
| [19_Solid_Liquid_Coexistence_method](examples/19_Solid_Liquid_Coexistence_method)        | Rui Zhao        |  Solid-liquid coexistence method for melting point calculation |
| [20_Impact](examples/20_Impact)        | Rui Zhao        |  Impact simulation |
| [21_Fatigue](examples/21_Fatigue)        | Rui Zhao        | Fatigue simulation |
| [22_Gas_Solid](examples/22_Gas_Solid)        | Shuo Zhang        | Gas-Solid simulation |
| [23_Surface_Reconstruction](examples/23_Surface_Reconstruction)        | Cheng Qian        | Pt surface reconstruction simulation |
| [24_Ionic_Conductivity](examples/24_Ionic_Conductivity) | Zihan Yan | Ionic conductivity of cubic Li<sub>7</sub>La<sub>3</sub>Zr<sub>2</sub>O<sub>12</sub> |
| [25_lattice_dynamics_kappa](examples/25_lattice_dynamics_kappa) | Zezhu Zeng | Lattice dynamics for PbTe |



## How to run the examples?

* First, compile the GPUMD package by typing `make` in `src/`. You will get the executables `gpumd` and `nep` in `src/`.

* Then, go to the directory of an example and type one of the following commands:
  * `path/to/gpumd`
  * `path/to/nep`
  
* By default, the `nep` executable will use all the visible GPUs in the system. 
This is also the case for the `gpumd` executable when using a NEP model.
The visible GPU(s) can be set by the following command before running the code:
```
export CUDA_VISIBLE_DEVICES=[list of GPU IDs]
# examples:
export CUDA_VISIBLE_DEVICES=0 # only use GPU with ID 0
export CUDA_VISIBLE_DEVICES=1 # only use GPU with ID 1
export CUDA_VISIBLE_DEVICES=0,2 # use GPUs with ID 0 and ID 2
```
If you are using a job scheduling system such as `slurm`, you can set something as follows
```
#SBATCH --gres=gpu:v100:2 # using 2 V100 GPUs
```
We suggest use GPUs of the same type, otherwise a fast GPU will wait for a slower one.
The parallel efficiency of the `nep` executable is high (about 90%) unless you have a very small training data set or batch size.
The parallel efficiency of the 	`gpumd` executable depends on the number of atoms per GPU. Good parallel efficiency requires this number to be larger than about 1e5.

By default, the system is partitioned along the thickest direction, but one can overwrite this by specifying a partition direction in the following way:
```
potential YOUR_NEP_MODEL.txt   # use the default partition
potential YOUR_NEP_MODEL.txt x # force to partition along the x direction (the a direction for triclinic box)
potential YOUR_NEP_MODEL.txt y # force to partition along the y direction (the b direction for triclinic box)
potential YOUR_NEP_MODEL.txt z # force to partition along the z direction (the c direction for triclinic box)
```

## References

[1] Zheyong Fan, Yanzhou Wang, Penghua Ying, Keke Song, Junjie Wang, Yong Wang, Zezhu Zeng, Ke Xu, Eric Lindgren, J. Magnus Rahm, Alexander J. Gabourie, Jiahui Liu, Haikuan Dong, Jianyang Wu, Yue Chen, Zheng Zhong, Jian Sun, Paul Erhart, Yanjing Su, Tapio Ala-Nissila,
[GPUMD: A package for constructing accurate machine-learned potentials and performing highly efficient atomistic simulations](https://doi.org/10.1063/5.0106617), The Journal of Chemical Physics **157**, 114801 (2022).

