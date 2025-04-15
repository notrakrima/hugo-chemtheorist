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
{ccsd-f12b,gem_beta=mygeminalbeta,df_basis=df,df_basis_exch=jk,ri_basis=ri,SCALE_TRIP=1}
else
{uccsd-f12b,gem_beta=mygeminalbeta,df_basis=df,df_basis_exch=jk,ri_basis=ri,SCALE_TRIP=1}
endif
endproc

basis={
default,cc-pvdz-f12
set,df
default,cc-pvdz-f12/mp2fit
set,jk
default,cc-pvdz-f12/jkfit
set,ri
default,cc-pvdz-f12/optri}
set,mygeminalbeta=0.9
show,mygeminalbeta
show,e*
asse_ccsd_f12b
escf2=energr
eccsdf122=energc
eccsdf12corr2=eccsdf122-escf2

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
asse_ccsd_f12b
escf3=energr
eccsdf123=energc
eccsdf12corr3=eccsdf123-escf3

basis
sp,h,vdz;c
spd,b,aug-cc-pvdz;c
spd,c,aug-cc-pvdz;c
spd,n,aug-cc-pvdz;c
spd,o,aug-cc-pvdz;c
spd,f,aug-cc-pvdz;c
spd,al,aug-cc-pv(d+d)z;c
spd,si,aug-cc-pv(d+d)z;c
spd,p,aug-cc-pv(d+d)z;c
spd,s,aug-cc-pv(d+d)z;c
spd,cl,aug-cc-pv(d+d)z;c
end
hf
if(multiplicity.eq.1)then
{ccsd(t);}
eccsd2=energc(1)-energr(1)
et2=energt(1)-energc(1)
else
{uccsd(t);}
eccsd2=energc(1)-energr(1)
et2=energt(1)-energc(1)
endif

basis
spd,h,vtz;c
spdf,b,aug-cc-pvtz;c
spdf,c,aug-cc-pvtz;c
spdf,n,aug-cc-pvtz;c
spdf,o,aug-cc-pvtz;c
spdf,f,aug-cc-pvtz;c
spdf,al,aug-cc-pv(t+d)z;c
spdf,si,aug-cc-pv(t+d)z;c
spdf,p,aug-cc-pv(t+d)z;c
spdf,s,aug-cc-pv(t+d)z;c
spdf,cl,aug-cc-pv(t+d)z;c
end
hf
if(multiplicity.eq.1)then
{ccsd(t);}
eccsd3=energc(1)-energr(1)
et3=energt(1)-energc(1)
else
{uccsd(t);}
eccsd3=energc(1)-energr(1)
et3=energt(1)-energc(1)
endif

basis
sp,H,cc-pVDZ-DK;c
spd,B,cc-pVDZ-DK;c
s,B ,0.0310500
p,B ,0.0237800
d,B ,0.0904000
spd,C,cc-pVDZ-DK;c
s,C ,0.0469000
p,C ,0.0404100
d,C ,0.1510000
spd,N,cc-pVDZ-DK;c
s,N ,0.0612400
p,N ,0.0561100
d,N ,0.2300000
spd,O,cc-pVDZ-DK;c
s,O ,0.0789600
p,O ,0.0685600
d,O ,0.3320000
spd,F,cc-pVDZ-DK;c
s,F ,0.0986300
p,F ,0.0850200
d,F ,0.4640000
sp,Al,cc-pVDZ-DK;c
d,Al,1.195,0.1890000,0.0535000
s,Al,0.0231000
p,Al,0.0153000
sp,Si,cc-pVDZ-DK;c
d,SI,1.803,0.2750000,0.0823000
s,SI,0.0332000
p,SI,0.0250000
sp,P,cc-pVDZ-DK;c
d,P ,2.506,0.3730000,0.1130000
s,P ,0.0417000
p,P ,0.0343000
sp,S,cc-pVDZ-DK;c
d,S ,2.994,0.4790000,0.1520000
s,S ,0.0507000
p,S ,0.0399000
sp,Cl,cc-pVDZ-DK;c
d,CL,3.652,0.6000000,0.1960000
s,CL,0.0608000
p,CL,0.0466000
end
dkroll=1
if(multiplicity.eq.1)then
hf
{ccsd(t);}
else
hf
{uccsd(t);}
endif
erelccsd=energc
erelccsdt=energy
erelt=erelccsdt-erelccsd

basis,aug-cc-pv(d+d)z,h=vdz
dkroll=0
if(multiplicity.eq.1)then
hf
{ccsd(t);}
else
hf
{uccsd(t);}
endif
show,e*
enonrelccsd=energc
enonrelccsdt=energy
enonrelt=enonrelccsdt-enonrelccsd

deltarelccsd=erelccsd-enonrelccsd
deltarelpart=erelt-enonrelt
deltarelccsdt=deltarelccsd+deltarelpart

basis,cc-pwCVTZ,h=cc-pVTZ
if(multiplicity.eq.1)then
hf
{ccsd;}
else
hf
{uccsd;}
endif
show,e*
efcccsd=energc

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
{ccsd(t);}
else
hf
{uccsd(t);}
endif
show,e*
efcccsdnof=energc
efcccsdtnof=energy
efctnof=efcccsdtnof-efcccsdnof

basis,cc-pwCVTZ,h=cc-pVTZ
if(multiplicity.eq.1)then
hf
{ccsd;core,c1,c2,c3,c4,c5,c6,c7,c8}
else
hf
{uccsd;core,c1,c2,c3,c4,c5,c6,c7,c8}
endif
show,e*
eeaccsd=energc

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
{ccsd(t);core,c1,c2,c3,c4,c5,c6,c7,c8}
else
hf
{uccsd(t);core,c1,c2,c3,c4,c5,c6,c7,c8}
endif
show,e*
eeaccsdnof=energc
eeaccsdtnof=energy
eeatnof=eeaccsdtnof-eeaccsdnof

escflimit=escf3+(escf3-escf2)/((3.0/2.0)^5.0 - 1.0)
eccsdlimit_all=eccsdf12corr3+(eccsdf12corr3-eccsdf12corr2)/((3.0/2.0)^3.67 - 1.0)
eccsdlimit_1st=eccsdf12corr3+(eccsdf12corr3-eccsdf12corr2)/((3.0/2.0)^3.38 - 1.0)
etlimit=et3+(et3-et2)/((3.0/2.0)^3.22 - 1.0)
ecvccsd=eeaccsd-efcccsd
ecvpart=eeatnof-efctnof
deltacvccsdt=1.1*ecvccsd+ecvpart
ew1f12val_all=escflimit+eccsdlimit_all+etlimit
ew1f12all_all=escflimit+eccsdlimit_all+etlimit+deltacvccsdt
ew1f12allrel_all=escflimit+eccsdlimit_all+etlimit+deltacvccsdt+deltarelccsdt
ew1f12val_1st=escflimit+eccsdlimit_1st+etlimit
ew1f12all_1st=escflimit+eccsdlimit_1st+etlimit+deltacvccsdt
ew1f12allrel_1st=escflimit+eccsdlimit_1st+etlimit+deltacvccsdt+deltarelccsdt

show,escf2,escf3
show,eccsdf122,eccsdf123
show,et2,et3
show,eccsdf12corr2,eccsdf12corr3
show,deltarelccsd,deltarelpart
show,efcccsd,efcccsdnof,efcccsdtnof,efctnof
show,eeaccsd,eeaccsdnof,eeaccsdtnof,eeatnof
show,ecvccsd,ecvpart
show,escflimit,eccsdlimit_all,eccsdlimit_1st,etlimit,deltarelccsdt,deltacvccsdt
show,ew1f12val_all,ew1f12all_all,ew1f12allrel_all
show,ew1f12val_1st,ew1f12all_1st,ew1f12allrel_1st






