memory,200,M
gthresh,energy=1d-10,grid=1d-6
explicit,singtrip_os=1,ansatz=3c(fix) 
ANGSTROM 
geomtyp=xyz 
geom={
O        0.000000    0.000000    0.117790 
H        0.000000    0.755453   -0.471161 
H        0.000000   -0.755453   -0.471161 
}
multiplicity=1 
basis,cc-pvdz
{rhf;wf,10,1,0} 

! ---------------------------------------------------
! Set deepcorefreeze here
! ---------------------------------------------------

c1 = 0
c2 = 0
c3 = 0
c4 = 0
c5 = 0
c6 = 0
c7 = 0
c8 = 0

! ---------------------------------------------------
! should not need to change anything below this line
! ---------------------------------------------------


proc asse_ccsd_f12b
{hf}
if(multiplicity.eq.1)then
{ccsd-f12b,maxit=222,gem_beta=mygeminalbeta,df_basis=df,df_basis_exch=jk,ri_basis=ri,SCALE_TRIP=1}
else
{uccsd-f12b,maxit=222,gem_beta=mygeminalbeta,df_basis=df,df_basis_exch=jk,ri_basis=ri,SCALE_TRIP=1}
endif
endproc

proc asse_ccsdt_f12b
{hf}
if(multiplicity.eq.1)then
{ccsd(t)-f12b,maxit=222,gem_beta=mygeminalbeta,df_basis=df,df_basis_exch=jk,ri_basis=ri,SCALE_TRIP=1}
else
{uccsd(t)-f12b,maxit=222,gem_beta=mygeminalbeta,df_basis=df,df_basis_exch=jk,ri_basis=ri,SCALE_TRIP=1}
endif
endproc

! VTZ BASIS SET
basis={
default,cc-pvtz-f12
set,df
default,cc-pvtz-f12/mp2fit
set,jk
default,cc-pvtz-f12/jkfit
set,ri
default,cc-pvtz-f12/optri}
set,mygeminalbeta=1.0
show,mygeminalbeta
show,e*
asse_ccsdt_f12b
escf3=energr
eccsdf123=energc
eccsdf12corr3=eccsdf123-escf3
et3f12=energt(1)-eccsdf123



! VQZ BASIS SET
basis={
default,cc-pvqz-f12
set,df
default,cc-pvqz-f12/mp2fit
set,jk
default,cc-pvqz-f12/jkfit
set,ri
default,cc-pvqz-f12/optri}
set,mygeminalbeta=1.0
show,mygeminalbeta
show,e*
asse_ccsd_f12b
escf4=energr
eccsdf124=energc
eccsdf12corr4=eccsdf124-escf4

!
! frozen core relativistic step
!
basis
spd,H,vtz-dk;c
spdf,B ,vtz-dk;c
s,B,0.029140
p,B,0.020960
d,B,0.060400
f,B,0.163000
spdf,C ,vtz-dk;c
s,C,0.044020
p,C,0.035690
d,C,0.100000
f,C,0.268000
spdf,N ,vtz-dk;c
s,N,0.057600
p,N,0.049100
d,N,0.151000
f,N,0.364000
spdf,O ,vtz-dk;c
s,O,0.073760
p,O,0.059740
d,O,0.214000
f,O,0.500000
spdf,F ,vtz-dk;c
s,F,0.091580
p,F,0.073610
d,F,0.292000
f,F,0.724000
sp,AL,vtz-dk;c
d,AL,1.57000000,0.333000000,0.111000000,0.0357000000
f,AL,vtz-dk;c
s,AL,0.02210
p,AL,0.01460
f,AL,0.08580
sp,SI,vtz-dk;c
d,SI,2.30300000,0.476000000,0.160000000,0.0551000000
f,SI,vtz-dk;c
s,SI,0.03300
p,SI,0.02370
f,SI,0.12500
sp,P ,vtz-dk;c
d,P ,3.12000000,0.648000000,0.218000000,0.0775000000
f,P ,vtz-dk;c
s,P,0.04090
p,P,0.03070
f,P,0.16500
sp,S ,vtz-dk;c
d,S ,3.75600000,0.812000000,0.273000000,0.101000000
f,S ,vtz-dk;c
s,S,0.04970
p,S,0.03510
f,S,0.21800
sp,CL,vtz-dk;c
d,CL,4.61000000,1.01100000,0.339000000,0.130000000
f,CL,vtz-dk;c
s,CL,0.05910
p,CL,0.04190
f,CL,0.31200
end
dkroll=1
if(multiplicity.eq.1)then
hf
{ccsd(t);maxit,120;}
else
hf
{uccsd(t);maxit,120;}
endif
erelccsdw2=energc
erelccsdtw2=energy
ereltw2=erelccsdtw2-erelccsdw2

!
! frozen core nonrelativistic step
!
basis,aug-cc-pv(t+d)z,h=vtz
dkroll=0
if(multiplicity.eq.1)then
hf
{ccsd(t);maxit,120;}
else
hf
{uccsd(t);maxit,120;}
endif
show,e*
enonrelccsdw2=energc
enonrelccsdtw2=energy
enonreltw2=enonrelccsdtw2-enonrelccsdw2

deltarelccsdw2=erelccsdw2-enonrelccsdw2
deltarelpartw2=ereltw2-enonreltw2
deltarelccsdtw2=deltarelccsdw2+deltarelpartw2

!
! frozen core CCSD and (T) steps 
!

basis,aug-cc-pwCVTZ,h=cc-pVTZ
if(multiplicity.eq.1)then
hf
{ccsd;maxit,120;}
else
hf
{uccsd;maxit,120;}
endif
show,e*
efcccsdw2=energc

basis
sp,h,cc-pVTZ;c
spd,be,cc-pwCVTZ;c
spd,b,cc-pwCVTZ;c
spd,c,cc-pwCVTZ;c
spd,n,cc-pwCVTZ;c
spd,o,cc-pwCVTZ;c
spd,f,cc-pwCVTZ;c
spd,mg,cc-pwCVTZ;c
spd,al,cc-pwCVTZ;c
spd,si,cc-pwCVTZ;c
spd,p,cc-pwCVTZ;c
spd,s,cc-pwCVTZ;c
spd,cl,cc-pwCVTZ;c
end

if(multiplicity.eq.1)then
hf
{ccsd(t);maxit,120;}
else
hf
{uccsd(t);maxit,120;}
endif
show,e*
efcccsdnof=energc
efcccsdtnof=energy
efctnof=efcccsdtnof-efcccsdnof

!
! all electron CCSD and (T) steps
!

basis,aug-cc-pwCVTZ,h=cc-pVTZ
if(multiplicity.eq.1)then
hf
{ccsd;maxit,120;core,c1,c2,c3,c4,c5,c6,c7,c8}
else
hf
{uccsd;maxit,120;core,c1,c2,c3,c4,c5,c6,c7,c8}
endif
show,e*
eeaccsdw2=energc

basis
sp,h,cc-pVTZ;c
spd,be,cc-pwCVTZ;c
spd,b,cc-pwCVTZ;c
spd,c,cc-pwCVTZ;c
spd,n,cc-pwCVTZ;c
spd,o,cc-pwCVTZ;c
spd,f,cc-pwCVTZ;c
spd,mg,cc-pwCVTZ;c
spd,al,cc-pwCVTZ;c
spd,si,cc-pwCVTZ;c
spd,p,cc-pwCVTZ;c
spd,s,cc-pwCVTZ;c
spd,cl,cc-pwCVTZ;c
end

if(multiplicity.eq.1)then
hf
{ccsd(t);maxit,120;core,c1,c2,c3,c4,c5,c6,c7,c8}
else
hf
{uccsd(t);maxit,120;core,c1,c2,c3,c4,c5,c6,c7,c8}
endif
show,e*
eeaccsdnof=energc
eeaccsdtnof=energy
eeatnof=eeaccsdtnof-eeaccsdnof

escflimitw2=escf4
eccsdlimitw2=eccsdf12corr4+(eccsdf12corr4-eccsdf12corr3)/((4.0/3.0)^5.94 - 1.0)
etlimitw2=0.987*et3f12
ecvccsdw2=eeaccsdw2-efcccsdw2
ecvpart=eeatnof-efctnof
deltacvccsdtw2=1.1*ecvccsdw2+ecvpart
ew2f12val=escflimitw2+eccsdlimitw2+etlimitw2
ew2f12all=escflimitw2+eccsdlimitw2+etlimitw2+deltacvccsdtw2
ew2f12allrel=escflimitw2+eccsdlimitw2+etlimitw2+deltacvccsdtw2+deltarelccsdtw2

show,escflimitw2,eccsdlimitw2,etlimitw2,deltarelccsdtw2,deltacvccsdtw2
show,ew2f12val,ew2f12all,ew2f12allrel






