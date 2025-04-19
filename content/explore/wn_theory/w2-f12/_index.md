---
title: "How to run a W2-F12 calculation with Molpro"
date: 2025-04-15
draft: false
---

## How to run a W2-F12 calculation with Molpro:<sup>1</sup>

Click these links to download input and output files for running W2-F12 calculation for H2O with Molpro:

<!-- Using pure HTML for links to avoid Markdown parsing issues -->
<p>
  <a href="/files/w2-f12_h2o.com" download>Download W2-F12 Molpro input file</a> <!-- Added download attribute -->
  &nbsp;&nbsp;&nbsp; <!-- HTML entities should work fine between HTML tags -->
  <a href="/files/w2-f12_h2o.out" download>Download W2-F12 Molpro output file</a> <!-- Added download attribute -->
</p>


<br>

Here is a brief description of the final W2-F12 energies that are printed in the output file:

<!-- Using an HTML table for precise alignment -->
<table>
  <tbody>
    <tr>
      <td style="padding-right: 1em;"><code>EW2F12VAL</code></td>
      <td style="padding-right: 1em;"><code>=</code></td>
      <td style="padding-right: 1em;"><code>-76.37450958 AU</code></td>
      <td>! this is the nonrelativistic, valence CCSD(T)/CBS energy</td>
    </tr>
    <tr>
      <td style="padding-right: 1em;"><code>EW2F12ALL</code></td>
      <td style="padding-right: 1em;"><code>=</code></td>
      <td style="padding-right: 1em;"><code>-76.43285033 AU</code></td>
      <td>! this is the nonrelativistic, all-electron CCSD(T)/CBS energy</td>
    </tr>
    <tr>
      <td style="padding-right: 1em;"><code>EW2F12ALLREL</code></td>
      <td style="padding-right: 1em;"><code>=</code></td>
      <td style="padding-right: 1em;"><code>-76.48468089 AU</code></td>
      <td>! this is the relativistic, all-electron CCSD(T)/CBS energy</td>
    </tr>
  </tbody>
</table>


For further details see the Wn-F12 paper<sup>1</sup> and these reviews.<sup>2,3</sup>

<p> 
  Please <a href="/contact/">contact me</a> in case you need any additional information.
</p>


<br>

## References:

[1] A. Karton, J. M. L. Martin. Explicitly correlated Wn theory: W1-F12 and W2-F12, Journal of Chemical Physics, 136, 124114 (2012). http://dx.doi.org/10.1063/1.3697678  <a href="https://drive.google.com/uc?export=download&id=1Br1-ZAVzZ5wgogvl5WAEH4zMX5dQkt-a">**[Download PDF]**</a>
<br>
[2] A. Karton. A computational chemist’s guide to accurate thermochemistry for organic molecules. Wiley Interdisciplinary Reviews: Computational Molecular Science, 6, 292–310 (2016). http://dx.doi.org/10.1002/wcms.1249 <a href="https://drive.google.com/uc?export=download&id=1vIj_ALYdPggc9jJq2u-KlmOwltzTashO">**[Download PDF]**</a>
<br>
[3] A. Karton. Quantum Mechanical Thermochemical Predictions 100 years after the Schrödinger Equation. Annual Reports in Computational Chemistry, Vol 18, pg. 123–166 (2022). https://doi.org/10.1016/bs.arcc.2022.09.003 <a href="https://drive.google.com/uc?export=download&id=1TknjBFeJMuASu9nBoqse9DKrYjoT8K2z">**[Download PDF]**</a>
<br>



