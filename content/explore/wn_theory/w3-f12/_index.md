---
title: "How to run a W3-F12 calculation with MRCC"
date: 2025-04-15
draft: false
---

## How to run a W3-F12 calculation with MRCC:<sup>1</sup>

To run a W3-F12 calculation follow these steps:

1. Run a W2-F12 calculation using the Molpro script available [here](/explore/wn_theory/w2-f12/).

2. Run the following calculations with MRCC:
<br>
<a href="/files/h2o_ccsdpart_vdz.com" download>CCSD(T)/cc-pVDZ MRCC input file</a>
<br>
<a href="/files/h2o_ccsdtparq_vdz.com" download>CCSDT/cc-pVDZ and CCSDT(Q)/cc-pVDZ MRCC input file</a>
<br>
<a href="/files/h2o_ccsdpart_vtz.com" download>CCSD(T)/cc-pVTZ MRCC input file</a>
<br>
<a href="/files/h2o_ccsdt_vtz.com" download>CCSDT/cc-pVTZ MRCC input file</a>

3. Extrapolate the CCSDT–CCSD(T) difference from the cc-pV{D,T}Z basis sets.

4. Calculate the CCSDT(Q)–CCSDT difference with the cc-pVDZ basis set.

5. W3-F12 = W2-F12 + T–(T)/cc-pV{D,T}Z + (Q)/cc-pVDZ

For further details see the Wn-F12 paper<sup>1</sup> and these reviews.<sup>2,3</sup>

<p> 
  Please <a href="/contact/">contact me</a> in case you need any additional information.
</p>



## References:

[1] A. Karton, J. M. L. Martin. Explicitly correlated Wn theory: W1-F12 and W2-F12, Journal of Chemical Physics, 136, 124114 (2012). http://dx.doi.org/10.1063/1.3697678 <a href="https://drive.google.com/uc?export=download&id=1Br1-ZAVzZ5wgogvl5WAEH4zMX5dQkt-a">**[Download PDF]**</a>
<br>
[2] A. Karton. A computational chemist’s guide to accurate thermochemistry for organic molecules. Wiley Interdisciplinary Reviews: Computational Molecular Science, 6, 292–310 (2016). http://dx.doi.org/10.1002/wcms.1249 <a href="https://drive.google.com/uc?export=download&id=1vIj_ALYdPggc9jJq2u-KlmOwltzTashO">**[Download PDF]**</a>
<br>
[3] A. Karton. Quantum Mechanical Thermochemical Predictions 100 years after the Schrödinger Equation. Annual Reports in Computational Chemistry, Vol 18, pg. 123–166 (2022). https://doi.org/10.1016/bs.arcc.2022.09.003 <a href="https://drive.google.com/uc?export=download&id=1TknjBFeJMuASu9nBoqse9DKrYjoT8K2z">**[Download PDF]**</a>
<br>



