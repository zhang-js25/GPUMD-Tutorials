Reference for the Solid-Liquid Coexistence Method:
(1)DOI: 10.11900/0412.1961.2017.00053.
(2)DOI: https://doi.org/10.1103/PhysRevB.49.3109.
(3)https://doi.org/10.1063/1.4739085.

1_lmp
    LAMMPS Batch Modeling.
        Use the LAMMPS input script ('in.txt') to batch-generate 
            structures ('model.*.xyz).  
        Each structure is divided into two groups:  
            Upper half: Assigned to 'group 1'.  
            Lower half: Assigned to 'group 0'.  

2_gpumd
    GPUMD Melting Point Calculation. 
        Initial Configuration: Use the structures generated in 
            '1_lmp' as starting configurations.  
        NPT Equilibration: Perform NPT simulations using GPUMD to 
            equilibrate the system at target temperatures.  
        Potential Energy Analysis:  
            Calculate the average potential energy for each temperature 
            using the equilibrium data (last 1/10 of simulation steps).  
            Plot the potential energy vs. temperature curve; a sharp 
            jump in potential energy indicates the melting point.  
        Iterative Refinement:  
            If no melting point is detected in the first round, redefine a 
            refined temperature range and rerun simulations.  
        Repeat this process to narrow down the temperature range until 
            the melting point is accurately determined.


