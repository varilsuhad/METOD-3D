# MATLAB file explanations for `plotting/` and `others/`

This note summarizes what each openable MATLAB (`.m`) file in `plotting/` and `others/` is used for.

## `plotting/`

### `plotting/TMM_results.m`
- **Purpose:** Compares transfer-matrix-model (TMM) MT responses against three hp-FEM cases (`Case A/B/C`) along a receiver profile.
- **Inputs loaded:** `usuimodelFEFF.mat` (reference), `hpsonucCaseA.mat`, `hpsonucCaseB.mat`, `hpsonucCaseC.mat`.
- **What it computes/plots:**
  - Extracts impedance tensor components (`Zxx, Zxy, Zyx, Zyy`) and tipper components (`Tzx, Tzy`) at selected frequency/receiver indices.
  - Builds a 3x4 subplot layout showing real/imaginary parts of impedance and tipper terms.
  - Computes normalized RMS-like error measures (some annotations are currently commented out).
- **Use case:** Visual model-to-model comparison for a TMM benchmark case.

### `plotting/TMM_results2.m`
- **Purpose:** Compares several basis/order variants (linear, quadratic, cubic, and p4) against a reference for one profile/frequency setup.
- **Inputs loaded:** `usuimodelFEFF.mat`, `lineersonuc.mat`, `kuadsonuc.mat`, `kubiksonuc.mat`, `p4sonuc.mat`.
- **What it computes/plots:**
  - Converts impedance values to apparent resistivity and phase where needed.
  - Produces multi-panel comparisons (real/imag components, apparent resistivity/phase style comparisons) across methods.
- **Use case:** Method/order sensitivity study for the same MT scenario.

### `plotting/DTM1_results.m`
- **Purpose:** Compares DTM1 results across increasing mixed/full polynomial orders and against IE/reference data.
- **Inputs loaded:** `DTM1hiersonuc.mat`, `DTM1_IE_veri.mat`, `DTMp4.mat` (plus hard-coded reference table `E`).
- **What it computes/plots:**
  - Computes apparent resistivity and phase from complex impedance data for all tensor terms.
  - Builds an 8-panel figure (`rho_xx, phi_xx, rho_xy, ...`) versus frequency.
  - Overlays IE curve and order-wise solutions with different markers (1st/2nd/3rd mixed/full and 4th mixed).
- **Use case:** Convergence/accuracy visualization across discretization orders for DTM1.

---

## `others/`

### `others/evaluate_shape_function.m`
- **Purpose:** Small helper for tetrahedral shape-function evaluation.
- **Behavior:**
  - `ok==1`: returns barycentric scalar basis (`L1..L4`).
  - `ok~=1`: returns corresponding gradient vector mapped with Jacobian information.
- **Use case:** Called repeatedly inside element-integration routines.

### `others/quadJac.m`
- **Purpose:** Computes Jacobian transform for **quadratic tetrahedral geometry mapping**.
- **Outputs:**
  - `Jxyz`: inverse Jacobian mapping.
  - `det1`: signed determinant term (with orientation sign).
- **Use case:** Geometric mapping and integration for higher-order tetrahedra.

### `others/ELkurtet2.m`
- **Purpose:** Mesh-topology preprocessing and DoF numbering for tetrahedral EM formulation.
- **Main responsibilities:**
  - Sort/connect element nodes and construct edge graph.
  - Detect boundary nodes/edges/faces by checking min/max box boundaries.
  - Assign interior edge IDs (positive) and boundary tags (negative IDs).
  - Build element lookup table `EL` with node, edge, material (`rho`), and face-related indexing.
  - Build sparse adjacency/index maps (`K`, `K2`, `Y1`, etc.) used later during matrix assembly.
- **Use case:** One-time preassembly step before forming global system matrices.

### `others/hprefinementsubF.m`
- **Purpose:** Extracts and reindexes hp-refined sub-problem DoFs for selected receiver-adjacent elements.
- **Main responsibilities:**
  - Filters `EL` rows belonging to `recvelems`.
  - Modifies local edge/face DoF availability depending on how element nodes relate to `Knodes`.
  - Renumbers active local edge (`HPm1`) and face (`HPm2`) DoFs into compact local indexing.
  - Returns totals for local edge/face hp unknowns (`totkenarhp`, `totyuzeyhp`).
- **Use case:** Creates smaller localized systems for hp refinement around receiver regions.

### `others/first_mixed_order_fun.m`
- **Purpose:** Assembles first-order mixed FEM system contributions.
- **Outputs:**
  - `R1`: curl-curl-like sparse matrix.
  - `M1`: mass-like sparse matrix.
  - `sag`: two-column right-hand-side/source contribution container.
- **Implementation notes:**
  - Uses tetrahedral quadrature and vector basis operations with `evaluate_shape_function`.
  - Parallelized with `spmd` and reduced via `spmdReduce`.
  - Includes boundary/source coupling logic that maps field orientation to edge DoFs.

### `others/second_mixed_order_fun.m`
- **Purpose:** Assembles second-order mixed FEM system contributions (edge + face unknown extensions).
- **How it differs from first-order:**
  - Larger DoF space (`totkenar*2 + totyuzey*2`).
  - Additional coupling blocks beyond pure edge-edge terms.
  - Still returns `R1`, `M1`, and `sag` in the same conceptual form.
- **Implementation notes:**
  - Heavy element-by-element numerical integration with multiple quadrature rules.
  - Uses `spmd` parallel assembly and final reduction.

### `others/third_mixed_order_fun.m`
- **Purpose:** Assembles third-order mixed FEM system contributions with the largest local polynomial space in this folder.
- **DoF size:** `totkenar*3 + totyuzey*6 + totel*3`.
- **Implementation notes:**
  - Uses multiple high-order tetrahedral quadrature sets (including long hard-coded point/weight tables).
  - Parallel `spmd` assembly + reduction, similar architecture to first/second order routines.
- **Use case:** Highest-order mixed discretization option for improved accuracy (at higher cost).

---

## Also present in `others/`

There are three compiled MATLAB binaries (`.mexw64`) in the folder:
- `LUcuDSS.mexw64`
- `LUcuDSSMG.mexw64`
- `pardiso_LUC.mexw64`

These are compiled solver interfaces (not directly readable as MATLAB source), likely used for sparse/direct linear solves.
