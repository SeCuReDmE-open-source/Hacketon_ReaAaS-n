from src.quantum.neutro_quantum_module import NeutroQuantumModule

# Create a 3-qubit system
nqm = NeutroQuantumModule(n_qubits=3)

# Apply neutro-quantum gates
nqm.apply_neutro_gate(0, [np.pi/4, 0, 0])
nqm.apply_neutro_gate(1, [np.pi/2, np.pi/4, 0])

# Measure the system
probabilities = nqm.measure()