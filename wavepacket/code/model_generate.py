"""
@Author   : Xin Wu
@Time     : 2025/3/18 17:01
@File     : model_generate.py
@Remark   :
"""

from ase.build import graphene_nanoribbon
from ase.io import write

gnr = graphene_nanoribbon(50, 1000, type='armchair', sheet=True, vacuum=3.35 / 2, C_C=1.44)
gnr.euler_rotate(theta=90)
L = gnr.cell.lengths()
gnr.cell = gnr.cell.new((L[0], L[2], L[1]))
L = L[2]
gnr.center()
gnr.pbc = [True, True, False]
write("model.xyz", gnr)