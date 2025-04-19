---
title: "Multireference Diagnostics"
date: 2025-04-15
draft: false
---

## %TAE[(T)] Multireference Diagnostics

The %TAE[(T)] diagnostic is an energy-based diagnostic for multi-reference character which is a good a priori predictor for the magnitude of post-CCSD(T) contributions. In particular, there is a high statistical correlation between the %TAE[(T)] diagnostic and the magnitude of connected quadruple and quintuple excitations.[1,2,3] For the 140 molecules in the W4-11 database, a squared correlation coefficient of R^2 = 0.94 is obtained.[2]

The %TAE[(T)] diagnostic is calculated from the atomic and molecular CCSD and CCSD(T) energies. It is defined as:

$$
\text{%TAE}[(\text{T})] = 100 \times \frac{\text{TAE}[\text{CCSD(T)}] - \text{TAE}[\text{CCSD}]}{\text{TAE}[\text{CCSD(T)}]}
$$

where TAE[CCSD] and TAE[CCSD(T)] are the total atomization energies calculated at the CCSD and CCSD(T) levels, respectively.

The %TAE[(T)] diagnostic does not have a steep basis set dependence. Even CCSD(T)/cc-pVDZ energies give fairly useful estimates for post-CCSD(T) contributions, and CCSD(T)/cc-pVTZ energies result in %TAE[(T)] values that are close to the infinite basis set limit.[2]

## How to calculate %TAE[(T)] values

Here is a worked example of how to calculate the %TAE[(T)] diagnostic for C2H4 at the CCSD(T)/cc-pVTZ level:

1. Calculate the CCSD/cc-pVTZ and CCSD(T)/cc-pVTZ energies for the atoms:

<pre>
	  ROHF/cc-pVTZ for H = –0.49980981 Hartree
	  ROCCSD/cc-pVTZ for C = –37.778529074216 Hartree
	  ROCCSD(T)/cc-pVTZ for C = –37.780664543434 Hartree
</pre>

 2. Calculate the CCSD/cc-pVTZ and CCSD(T)/cc-pVTZ energies for the molecule:

<pre>
	  CCSD/cc-pVTZ for C2H4 = –78.423790315994
	  CCSD(T)/cc-pVTZ for C2H4 = –78.438791852740
</pre>

 3. Calculate the CCSD/cc-pVTZ and CCSD(T)/cc-pVTZ total atomization energies for the molecule:

<pre>
  	TAE[CCSD] = 2×(–37.778529074216) + 4×(–0.49980981) – (–78.423790315994) = 0.86749293 Hartree = 544.4 kcal/mol
  	TAE[CCSD(T)] = 2×(–37.780664543434) + 4×(–0.49980981) – (–78.438791852740) = 0.87822353 Hartree = 551.1 kcal/mol
</pre>

4. Calculate the %TAE[(T)] for the molecule:

<pre>
	%TAE[(T)] = 100×(TAE[CCSD(T)]–TAE[CCSD])/TAE[CCSD(T)] = 100×(551.1–544.4)/551.1 = 1.2%
</pre>

This %TAE[(T)] value indicates that the CCSD(T) method can be safely used for C2H4.


## How to interpret %TAE[(T)] values

1. %TAE[(T)] values smaller than 5% indicate that post-CCSD(T) contributions should not exceed 0.5 kcal/mol.

2. %TAE[(T)] values between 5–10% indicate that post-CCSD(T) contributions should generally not exceed 1.0 kcal/mol. In these cases the CCSD(T) method should be used with caution.

3. %TAE[(T)] values larger than 10% indicate that post-CCSD(T) contributions can certainly exceed 1.0 kcal/mol by significant amounts. In these cases the CCSD(T) method should not be used.

For further details see refs. [1–3].

## References


[1] A. Karton, E. Rabinovich, J. M. L. Martin, B. Ruscic. W4 theory for computational thermochemistry: In pursuit of confident sub-kJ/mol predictions. Journal of Chemical Physics 125, 144108 (2006).  http://dx.doi.org/10.1063/1.2348881  <a href="https://drive.google.com/uc?export=download&id=1Hp0toNL-Po1yjJzUvFTStV_dOzekXxwK">**[Download PDF]**</a>

[2] A. Karton, S. Daon, J. M. L. Martin. W4-11: A high-confidence dataset for computational thermochemistry derived from W4 ab initio data. Chemical Physics Letters 510, 165–178 (2011). http://dx.doi.org/10.1016/j.cplett.2011.05.007 <a href="https://drive.google.com/uc?export=download&id=1mFkIl2gW9_rtdruZLRmGk4FePVah-xQe">**[Download PDF]**</a>

[3] A. Karton. A computational chemist’s guide to accurate thermochemistry for organic molecules. Wiley Interdisciplinary Reviews: Computational Molecular Science, 6, 292–310 (2016). http://dx.doi.org/10.1002/wcms.1249  <a href="https://drive.google.com/uc?export=download&id=1vIj_ALYdPggc9jJq2u-KlmOwltzTashO">**[Download PDF]**</a>


