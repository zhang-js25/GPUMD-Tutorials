import numpy as np
import matplotlib.pyplot as plt

def parse_lattice(line):
    lattice_str = line.split('"')[1]
    params = list(map(float, lattice_str.split()))
    return params[0], params[4], params[8]

def read_ar_positions(file_path):
    ar_z = []
    with open(file_path, 'r') as f:
        n_atoms = int(f.readline())
        lattice_line = f.readline()
        
        if 'Lattice="' in lattice_line:
            lx, ly, lz = parse_lattice(lattice_line)
        else:
            print("Warning:Fail to find Lattice")
            exit(1)
        
        for _ in range(n_atoms):
            line = f.readline()
            if not line.strip():
                continue
            parts = line.split()
            element = parts[1]
            if element == 'Ar':
                z = float(parts[4])
                ar_z.append(z)
    return ar_z, lx, ly, lz

def calculate_density(ar_z, lx, ly, lz, bins=100):
    if not ar_z:
        return None, None
    bin_width = lz / bins
    counts, edges = np.histogram(ar_z, bins=bins, range=(0, lz))
    volume_per_bin = lx * ly * bin_width  # Volume of each bin（Å³）
    density = counts / volume_per_bin  # Number density（atoms/Å³）
    z_center = (edges[:-1] + edges[1:]) / 2  # Midpoint of each bin interval
    return z_center, density

def plot_density(z_center, density):
    if z_center is None:
        print("Warning:Fail to find Atom")
        exit(1)
    plt.figure(figsize=(10, 5))
    plt.plot(z_center, density, '-o', color='crimson', linewidth=1.8, markersize=4)
    plt.xlabel('Z Position (Å)', fontsize=12)
    plt.ylabel('Number Density (atoms/Å³)', fontsize=12)
    plt.title('Argon Atom Density Distribution along Z-axis', fontsize=14)
    plt.grid(alpha=0.4, linestyle='--')
    plt.tight_layout()
    plt.show()
    

if __name__ == "__main__":
    file_path = "oneframe.xyz"  # 替换为实际文件路径
    try:
        ar_z, lx, ly, lz = read_ar_positions(file_path)
        z_center, density = calculate_density(ar_z, lx, ly, lz)
        plot_density(z_center, density)
    except Exception as e:
        print(f"Error: Data parsing failed. Reason: {str(e)}")
        print("Please check if the file format matches the example (especially the lattice line and atomic coordinate columns)")
    