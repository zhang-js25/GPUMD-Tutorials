"""
@Author   : Xin Wu
@Time     : 2025/3/18 10:55
@File     : WP_Generation.py
@Remark   : 
"""

import numpy as np
import matplotlib.pyplot as plt
import yaml
import ase.io
import math
import cmath
from typing import Dict


class WavePacketHandler:
    """Handles wave packet configuration and phonon band data loading"""

    def __init__(self, config_dict: Dict):
        self.eta = config_dict["eta"]  # controls wave packet width
        self.A0 = config_dict["A0"]  # wave packet amplitude
        self.branch = config_dict["branch"]  # phonon branch
        self.k0 = config_dict["k0"]  # k-point index corresponding to wave number and frequency
        self.direction = config_dict["direction"]  # direction
        self.model_file_path = config_dict["model_file_path"]   # your model
        self.band_file_path = config_dict["band_file_path"]   # your band.yaml from phonopy
        self.dispersion_file_path = config_dict["dispersion_file_path"]   # your band.txt from phonopy
        self.loc_center = config_dict["loc_center"]   # the center location of your wavepacket
        self.u = None
        self.v = None

    # Dictionary mapping for branch and direction values
    BRANCH_MAP = {"ZA": 0, "TA": 1, "LA": 2}
    DIRECTION_MAP = {"x": 0, "y": 1, "z": 2}

    @property
    def branch_index(self) -> int:
        """Get branch index directly as a property"""
        return self.BRANCH_MAP.get(self.branch)

    @property
    def direction_index(self) -> int:
        """Get direction index directly as a property"""
        return self.DIRECTION_MAP.get(self.direction)


    def generate_wave_packet(self):

        model = ase.io.read(self.model_file_path)
        pos = model.positions
        with open(self.band_file_path) as f:
            band_data = yaml.load(f, Loader=yaml.SafeLoader)
        eigenval_data = np.genfromtxt(self.dispersion_file_path)
        eigenval_cm_1 = np.reshape(eigenval_data[:, 1], (-1, 3 * band_data["natom"]), order='F')
        eigenval_THz = eigenval_cm_1 / 33.35641

        index = np.tile([0, 1], len(pos) // 2 + 1)[:len(pos)]

        self.u = np.zeros_like(pos)
        self.v = np.zeros_like(pos)

        d_wavevector = 2.0 * math.pi / (math.sqrt(3) * band_data['nqpoint'] * band_data['lattice'][0][0])

        for i in range(len(pos)):
            idx = int(index[i])
            for j in range(3):
                eigen_vec = complex(
                    band_data['phonon'][self.k0]['band'][self.branch_index]['eigenvector'][idx][j][0],
                    band_data['phonon'][self.k0]['band'][self.branch_index]['eigenvector'][idx][j][1]
                )
                rel_pos = pos[i, self.direction_index] - self.loc_center
                phase = complex(0.0, self.k0 * d_wavevector * rel_pos)
                gaussian = math.exp(-(rel_pos ** 2) / (self.eta ** 2))
                wavepacket = self.A0 * eigen_vec * cmath.exp(phase) * gaussian

                self.u[i, j] = wavepacket.real
                # self.v[i, j] = (wavepacket * complex(0.0, -eigenval_cm_1[self.k0, self.branch_index])).real     # Ans * cm^(-1)
                # self.v *= 3e-5 * 2.0 * math.pi   # A * cm^(-1) ---> A * fs^(-1)

        model.positions += + self.u
        # model.set_velocities(self.v)
        model.write("model.xyz", format="extxyz")


        # Visualization
        plt.figure(figsize=(12, 4))
        plt.subplots_adjust(wspace=0.2)
        # Plot dispersion relation
        plt.subplot(121)
        for i in range(6):
            plt.plot(eigenval_data[0:band_data['nqpoint'], 0], eigenval_cm_1[:, i])
        # Plot the kpoint you choose
        plt.scatter(eigenval_data[self.k0, 0], band_data['phonon'][self.k0]['band'][self.branch_index]['frequency'], marker='*', s=60)
        # Segments on the wavevector
        gamma0 = eigenval_data[0, 0]
        M = eigenval_data[int(band_data['nqpoint'] / 3), 0]
        K = eigenval_data[int(2 * band_data['nqpoint'] / 3), 0]
        gamma1 = eigenval_data[int(3 * band_data['nqpoint'] / 3) - 1, 0]
        # Labeling and Identification
        plt.xlim(gamma0, gamma1)
        plt.xticks([gamma0, M, K, gamma1], ['$\Gamma$', 'M', 'K', '$\Gamma$'])
        plt.axvline(M, color='gray', ls='--')
        plt.axvline(K, color='red', ls='--')
        plt.axhline(0, color='blue', ls=':', lw=0.5)
        plt.ylabel('Frequency (cm$^{{-1}}$)')
        plt.title(f"Phonon dispersion ({self.branch}: {eigenval_THz[self.k0, self.branch_index]:.2f} THz)")
        # Plot wave packet for check
        plt.subplot(122)
        plt.plot(pos[:, self.direction_index] / 10, self.u[:, 0], label='x')
        plt.plot(pos[:, self.direction_index] / 10, self.u[:, 1], label='y')
        plt.plot(pos[:, self.direction_index] / 10, self.u[:, 2], label='z')
        plt.xlim(160, 280)
        plt.yticks([])
        plt.xlabel('Location (nm)')
        plt.ylabel('Amplitude of displacement')
        plt.title('Wave paceket illustration')
        plt.legend(frameon=False)
        # plt.show()
        plt.savefig("wp_init.png", dpi=300)

def main():

    config = {
        "eta": 150,
        "A0": 0.01,
        "branch": 'ZA',
        "k0": 20,
        "loc_center": 4.32 * 500,
        "direction": "y",
        "model_file_path": "./model_init.xyz",
        "band_file_path": "../phonon/band.yaml",
        "dispersion_file_path": "../phonon/band.txt",
    }

    simulator = WavePacketHandler(config)
    simulator.generate_wave_packet()

if __name__ == '__main__':
    main()