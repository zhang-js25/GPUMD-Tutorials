The 'momentum mirror' method is used to carry out the impact.

1. dump.C1.xyz
   Initial structure from ../0bak/2replace/poly.xyz.
2. model.xyz
   Modified dump.xyz: (1) set the left 0-5 A in the x direction 
   to group 1 (momentum mirror), the mass is 1e10 that is infinity, 
   and the other parts are group 0; (2) Set the boundary condition 
   to F T T, that is, the x direction is the free boundary, and the 
   y and z directions are the periodic boundary. 
3. run.in
   Isothermal equilibration is followed by impact.
4. UNEP-v1-model-with-ZBL.txt
   NEP potential, refer to: https://doi.org/10.1038/s41467-024-54554-x.
