This folder involves uniaxial fatigue simulations, focusing 
on cyclic loading to simulate the fatigue process. 
Refer to:
(1)https://doi.org/10.1063/5.0259061.
(2)Song, K., Zhao, R., Liu, J. et al. General-purpose 
   machine-learned potential for 16 elemental metals and their 
   alloys. Nat Commun 15, 10208 (2024). 
   https://doi.org/10.1038/s41467-024-54554-x.

Description of file:
1. create-run.sh
   shell script for 'run.in' file creation.
2. run.in 
   parameter settings file for the simulations,
   created by 'create-run.sh'.
3. UNEP-v1-model-with-ZBL.txt 
   NEP potential file.
4. model.xyz
   initial structure file for the simulations.
5. dump.xyz
   structure file.
6. z.sh
   submit job.