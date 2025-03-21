"""
@Author   : Xin Wu
@Time     : 2025/3/20 21:16
@File     : PostProcess.py
@Remark   : 
"""


from matplotlib import pyplot as plt
from ase.io import read

data= read(filename='./movie.xyz', index=":")
data_init = read("./model.xyz")


plt.plot(data_init.positions[:, 1] / 10, data[1].positions[:, 2] - data_init.positions[:, 2], label="10 ps")
plt.plot(data_init.positions[:, 1] / 10, data[2].positions[:, 2] - data_init.positions[:, 2], label="20 ps")
plt.plot(data_init.positions[:, 1] / 10, data[3].positions[:, 2] - data_init.positions[:, 2], label="30 ps")

plt.xlim(250, 400)
plt.xlabel('Location (nm)')
plt.ylabel('Amplitude of displacement')
plt.title('Wave paceket simulation')
plt.legend(frameon=False)
plt.yticks([])
# plt.show()
plt.savefig("result.png", dpi=300)