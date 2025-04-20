1. 0bak 
   - nep.txt: NEP potential file.  
   - model.*.xyz: Initial structure files sourced from 
     '../../1_lmp'. Atoms are pre-grouped into two regions; 
     use OVITO’s color-coding option to visualize the groups.  
   - restart.*.xyz: Output files from '../1init; simulations, 
     representing solid-liquid coexistence structures.  

2. 1init 
   - Auto-generated directory created by running the script '1init.sh'.  
   - Executes simulations to obtain solid-liquid coexistence 
     configurations, which serve as initial structures for subsequent 
     melting-point calculations in '2MP'. 
   - dump.xyz files have been removed to control directory size.

3. 2MP
   - Auto-generated directory created by running the script '2MP.sh'.  
   - Performs NPT isothermal equilibration simulations across:  
     - A range of specified compositions.  
     - A series of target temperatures.  
   - Outputs the average potential energy for each temperature to 
     generate a potential energy vs. temperature curve. A sharp 
     jump in the curve identifies the melting point.
   - Output files for individual temperatures have been deleted to 
     optimize storage usage.
