import os
import numpy as np
import matplotlib.pyplot as plt
import scipy.constants as consts

def read_msd_file(msd_file):
    data = np.loadtxt(msd_file)
    dts = data[:, 0]
    msds = np.sum(data[:, 1:4], axis=1)
    return dts, msds

def get_conversion_factor(volume, num_ions, temperature):
    vol = volume * 1e-24  # cm^3
    z = 1  # species_charge
    n = num_ions
    return (n / (vol * consts.N_A) * z**2 * (consts.N_A * consts.e)**2 / 
            (consts.R * temperature))

# Data dictionaries
volume_dict = {1000: 143800.537, 1100: 144724.540, 1200: 145702.580}
num_ions = 56 * 64
label = "Li$_7$La$_3$Zr$_2$O$_{12}$"

# Plot setup
plt.rcParams.update({'font.size': 10})
plt.figure(figsize=(5, 3.4), dpi=200)

temps = [1000, 1100, 1200]
sigma_Ts = []

# Process data
for temp in temps:
    msd_file = f'./{temp}K/msd.out'
    dts, msds = read_msd_file(msd_file)
    
    start = int(len(dts) * 0.1)
    end = int(len(dts) * 0.4)
    k, _ = np.polyfit(dts[start:end], msds[start:end], 1)
    
    D = k * 1e-4 / 6  # A^2/ps to cm^2/s
    conversion_factor = get_conversion_factor(volume_dict[temp], num_ions, temp)
    sigma_T = conversion_factor * D * temp
    
    sigma_Ts.append(sigma_T)
    plt.scatter(1000 / temp, np.log(sigma_T), color='C4', s=40)

# Fit and calculate activation energy
k_tetra, b_tetra = np.polyfit(1000 / np.array(temps), np.log(sigma_Ts), 1)
Ea = -k_tetra * 1000 * consts.k / consts.e
print(f"Ea: {Ea:.3f} eV")

# Plot fit line
plt.plot(1000 / np.array(temps), k_tetra * 1000 / np.array(temps) + b_tetra, 
         linestyle='-', linewidth=2, color='C4', label=label)

# Axes setup
plt.xlabel('1000/T (1/K)', fontsize=11)
plt.ylabel(r'$\ln(\sigma \cdot T)$ (K S/cm$^{-1}$)', fontsize=11)
plt.legend(loc='lower left', fontsize=9)

# Secondary x-axis
ax1 = plt.gca()
ax2 = ax1.twiny()
ax2.set_xticks(ax1.get_xticks())
ax2.set_xbound(ax1.get_xbound())
ax2.set_xticklabels([f"{1000/x:.0f}" for x in ax1.get_xticks()])
ax2.set_xlabel("T (K)", fontsize=11)

# Add Ea text
plt.text(0.925, 6.3, f'E$_a$ = {Ea:.3f} eV', rotation=-25, fontsize=12, color='C4')

plt.tight_layout()
#plt.show()
plt.savefig('Arrhenius_plot.png')