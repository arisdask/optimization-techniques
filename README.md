# Optimization-Techniques

This repository contains assignments and a project for the Optimization Techniques course at ECE AUTH. 
Each folder implements different optimization methods, with MATLAB code and reports for each task.

## Repository Structure & Overview

- **project/**: Final project implementing evolutionary algorithms for constrained traffic flow optimization.
    - **Methods:**
        - Custom Genetic Algorithm (roulette wheel selection, arithmetic crossover, Gaussian mutation)
        - Population initialization with constant or random total flow
        - Chromosome validation for network constraints
        - Visualization of optimization progress and results
        - Constrained optimization using MATLAB's `fmincon` for comparison and verification

- **work1/**: One-dimensional optimization methods.
  - **Methods:**
    - Dichotomous Search
    - Golden Section Search
    - Fibonacci Method
    - Dichotomous Search with Derivatives

- **work2/**: Multivariate optimization methods.
  - **Methods:**
    - Steepest Descent
    - Newton's Method
    - Levenberg-Marquardt Algorithm

- **work3/**: Constrained optimization methods.
  - **Methods:**
    - Steepest Descent (with and without constraints)
    - Projection methods for constraints

## How to Use

Navigate to each folder for MATLAB code and reports. 
Each method is implemented in the corresponding `matlabCode/src/` subfolder, 
with main scripts in `matlabCode/` and plots in `plots/`.

For details on each method, see the respective report PDFs in each folder.
