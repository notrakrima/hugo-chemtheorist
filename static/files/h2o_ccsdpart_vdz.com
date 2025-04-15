basis=cc-pVDZ
mem=220000MB
calc=CCSD(T)
verbosity=3
mult=1
charge=0
scftype=rhf
scfmaxit=1000
geom=xyz
3
COMMENT LINE
O        0.000000    0.000000    0.117790
H        0.000000    0.755453   -0.471161
H        0.000000   -0.755453   -0.471161

