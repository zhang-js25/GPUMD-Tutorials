方法：https://blog.csdn.net/lammps_jiayou/article/details/118099651
1. 生成单晶Fe晶胞
   atomsk --create fcc 3.615 Cu Cu.xsf
2. 建立多晶节点文件，polycrystal.txt ：
   box 150 150 20     #cell size
   random 10          #random 20 grain
3. 生成多晶文件final.lmp
   atomsk --polycrystal Cu.xsf polycrystal.txt final.lmp -wrap
4. 使用文本编辑器打开final.lmp文件，做以下修改：
   （1）原子类型由1种改为3种
        3 atom types
   （2）添加Ni、Cr原子摩尔质量
        Masses   
        1  55.84500000    # Fe 
        2  58.69          # Ni 
        3  51.96          #Cr
5. 替换原子生成合金结构
   编写in文件，在lammps中使用替换原子法，将部分Fe原子按照比例替换为Ni、Cr，得到合金多晶结构。
   in文件脚本如下：
   units           metal 
   boundary        p p p 
   atom_style      atomic 
   timestep        0.001 
   neighbor        0.2 bin 
   read_data       final.lmp 
   set             type 1 type/ratio 2 0.33 8793 
   set             type 1 type/ratio 3 0.5 56332 
   write_data      Fe-Ni-Cr.data

                     
