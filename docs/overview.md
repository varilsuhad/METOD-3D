## Documentation

This repository provides a modular research framework for 3D MT forward modeling. The main components of the workflow are:

### 1. Mesh Definition

Meshes are provided in `/meshes/` and define the computational domain, including topography and conductivity structure.

### 2. Basis Functions

Hierarchical Nédélec (first-family) vector basis functions are implemented in `/others/`.
These support:

* First-order (linear) edge elements
* Higher-order hierarchical extensions
* Mixed-order (p-adaptive) configurations

### 3. System Assembly

The finite element system is assembled using curl-conforming formulations of Maxwell’s equations in the frequency domain (E-field formulation).

### 4. Linear Solver

The resulting sparse complex-valued system is solved using:

* CPU-based direct solvers
* GPU-accelerated solvers (cuDSS) for large-scale problems

### 5. Post-processing

Computed fields are transformed into:

* Impedance tensor components
* Apparent resistivity and phase
* Optional tipper responses

### 6. Benchmark Models

Two primary benchmark setups are included:

* **Two-Mountain Model (TMM)** – used for studying p-refinement and accuracy
* **Dublin Test Model 1 (DTM1)** – used for validation and conditioning analysis

---

This documentation is intended to provide sufficient guidance to reproduce the numerical experiments presented in the accompanying manuscript.
