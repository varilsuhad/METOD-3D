# METOD-3D  
**3D Magnetotelluric Forward Modeling on Unstructured Meshes with Higher-Order Vector Basis Functions and Multi-GPU Acceleration**

---

## Overview

METOD-3D is a research-oriented software package for 3D magnetotelluric (MT) forward modeling using unstructured tetrahedral meshes and hierarchical curl-conforming vector basis functions. The code is designed to investigate the interplay between polynomial order, mesh resolution, and computational performance, with particular emphasis on large-scale simulations enabled by multi-GPU direct solvers.

This repository accompanies the manuscript:

> *3D magnetotelluric forward modeling on unstructured meshes: the interplay of polynomial order, mesh resolution, and multi-GPU acceleration*  
> (submitted to *Computers & Geosciences*)

---

## Key Features

- **Unstructured tetrahedral meshes** for complex geometries and topography  
- **Hierarchical Nédélec (first-family) vector basis functions** up to higher orders  
- Support for **mixed-order (p-adaptive) formulations**  
- **Frequency-domain E-field formulation** under quasi-static approximation  
- **Direct sparse solvers with multi-GPU support** (cuDSS / GPU-enabled workflows)  
- Flexible framework for **accuracy vs computational cost studies**  
- Benchmark-ready implementations (e.g., Two-Mountain Model, Dublin Test Model)

---

## Scientific Scope

This codebase is developed to explore:

- The impact of **polynomial order (p-refinement)** on MT response accuracy  
- The role of **mesh resolution** in high-order finite element formulations  
- The effectiveness of **hybrid polynomial strategies**  
- Trade-offs between **DoF count, conditioning, and solver performance**  
- Practical limits of higher-order methods on realistic geophysical models  

---

## Repository Structure

> ⚠️ The repository is under active development. Structure may evolve.

Typical components include:

/mesh/ Mesh generation and preprocessing tools
/basis/ Hierarchical vector basis function definitions
/assembly/ FEM matrix assembly routines
/solver/ Linear system solution (CPU/GPU workflows)
/examples/ Benchmark models and test cases
/utils/ Supporting utilities and scripts


---

## Current Status

This repository is being actively prepared for public release alongside the manuscript.  

- Core numerical implementations are complete and validated  
- Code organization and documentation are being refined  
- Example workflows and reproducibility scripts are being added  

> The current version reflects the research code used in the manuscript experiments.

---

## Getting Started

Detailed setup and usage instructions will be provided soon.  

In the meantime, experienced users may explore:

- Example scripts in `/examples/`  
- Assembly and solver routines for customization  
- Basis function implementations for extension or verification  

---

## Related Projects

Earlier developments related to this work:

- **3DMTHYBRID**  
  Hybrid finite element / finite difference MT modeling  
  https://github.com/varilsuhad/3DMTHYBRID  

- **DEVA3DMT**  
  3D MT inversion framework with GPU acceleration  
  https://github.com/varilsuhad/DEVA3DMT  

---

## Citation

If you use this code or concepts from this work, please cite:
(Manuscript under review – citation will be updated upon publication)


---

## Notes

- This is a **research codebase**, not a production-ready software package  
- Numerical performance and stability depend on mesh design and solver configuration  
- Users are expected to have familiarity with finite element methods and MT modeling  

---

## Contact

For questions or collaboration inquiries:

**Deniz Varılsüha**  
GitHub: https://github.com/varilsuhad  
Email: deniz.varilsuha@itu.edu.tr
---

## License

(To be specified)
