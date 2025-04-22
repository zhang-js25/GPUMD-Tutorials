1. In this example we provide the input filesfor simulate the Pt(100) surface reconstruction (Qian et al.  https://doi.org/10.1002/smll.202404274)
2. Fix the bottom of the Pt slab model, and set the group as 1 (can check the group information in model.xyz)
3. Prepare the GPUMD input file (run.in ) and NEP model for Pt 
(The training/test data and training parameters for nep.txt in this example can be found at https://zenodo.org/records/14647737)
4. Submit the GPUMD job for Pt(100) surface reconstruction
5. The time required for surface reconstruction is 10 ns (3.8 hours for this simulation on RTX 4090). 
6. Check the dump.xyz after you finished the simulation, and you can open the view_CN.ovito and view the dump.xyz or restart.xyz to check the atomic coordination change.
note: Since the dump.xyz is too large, we didnot provide the dump.xyz in the example
7. Read the thermo.out and use Python plot the energy profile during the NVT simulation.