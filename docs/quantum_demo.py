import numpy as np
import sys
import os

# Add parent directory to path so we can import modules properly
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# Try to import the module from different possible locations
try:
    # First try directly importing from the neutrosophic folder
    from neutrosophic_quantum_FfeD_enhancement.quantum import NeutroQuantumModule
except ImportError:
    try:
        # Try with folder name as written in the directory structure
        sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 
                                      "neutrosophic quantum FfeD enhancement"))
        from quantum import NeutroQuantumModule
    except ImportError:
        try:
            # Try local path
            from neutro_quantum_module import NeutroQuantumModule
        except ImportError:
            print("Failed to import NeutroQuantumModule. Check module path.")
            sys.exit(1)

# Create a 3-qubit system
nqm = NeutroQuantumModule(n_qubits=3)

# Apply neutro-quantum gates
nqm.apply_neutro_gate(0, [np.pi/4, 0, 0])
nqm.apply_neutro_gate(1, [np.pi/2, np.pi/4, 0])

# Measure the system
probabilities = nqm.measure()
print(f"Quantum system measurement probabilities: {probabilities}")