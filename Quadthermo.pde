{ Fill in the following sections (removing comment marks ! if necessary),
  and delete those that are unused.}
TITLE 'Quadthermo'     { the problem identification }
COORDINATES cartesian2  { coordinate system, 1D,2D,3D, etc }
VARIABLES        { system variables }
  Temp              { Temperature }
! SELECT         { method controls }
 DEFINITIONS    { parameter definitions }
!b=curl(A)
!ybcok=table('ybcok.txt')
!steel=table('data_steel_k.txt')
r=1.2 !10*cm
d=0.4 !10*cm
l=0.4 !10*cm
lroot=l/sqrt(2) !10*cm
w=0.3 !10*cm
wpart=w/(2*sqrt(2)) !10*cm
wroot=w/sqrt(2) !10*cm
t=0.05 !10*cm
TROOT=T/SQRT(2)
DELTA=0.06 !10*cm
DELROOT=DELTA/SQRT(2)
s=0.01 !10*cm
sroot=s/sqrt(2)

he=0.01 !10*cm
heroot=he*sqrt(2)
casein=0.005 !10*cm
caseinroot=casein*sqrt(2)
coldcase=0.005 !10*cm
coldcaseroot=coldcase*sqrt(2)
caseout=0.005 !10*cm
caseoutroot=caseout*sqrt(2)
vac=0.007 !10*cm
vacroot=vac*sqrt(2)
p=he+casein+coldcase+caseout+vac !10*cm
proot=p/sqrt(2) 
thick=delta-p !10*cm
thickroot=thick/sqrt(2)
hand=s+2*p+t+thick !10*cm
handroot=hand/sqrt(2)
bend=0.07 !10*cm
bendroot=bend/sqrt(2)
k=0.05 !10*cm
kroot=k/sqrt(2)
c=0.2 !10*m
CROOT=C/SQRT(2)
length=c+2*p+thick !10*cm
lengthroot=length/sqrt(2)

!Dist=globalmax(Disteq)


slant=(r-wroot-r/3)/2
slantroot=slant
space=r-wpart-lroot-slantroot !10*cm
rspace=wpart+lroot+slantroot

Tempcold=39 !K
roomtemp= 300 !k
cond=1
J=0
mu0=4*pi*1e-7
mur=1
mu=mu0*mur
!muiron=1+1507*exp(-magnitude(b)/1.443)^3.725
Jcoil=1e6
!magB=magnitude(b)
!v=vector(dx(magB), dy(magB))
! INITIAL VALUES
EQUATIONS        { PDE's, one for each variable }
  div(-cond*grad(Temp))=0 { one possibility }
! CONSTRAINTS    { Integral constraints }
BOUNDARIES       { The domain definition }
  REGION 'Air'
cond= 26.2 !W/mK
Start(0,0) value(temp)=roomtemp line to (rspace+d,0) value(temp)=roomtemp line to (rspace+d,r+d) value(temp)=roomtemp line to(0,r+d) value(temp)=roomtemp line to close
  REGION 'Soft Iron'
cond= 73 !W/mK
Start (0, space) line to (wpart, space-wpart) to (wpart+lroot +2*delroot, space-wpart+lroot+2*delroot) to (wpart+lroot +2*delroot+slant, space-wpart+lroot+2*delroot-slant) to (wpart+lroot +2*delroot+slant,0) to (rspace+d,0) to (rspace+d,r+d) to (0,r+d) to (0,r) to (wpart+lroot +2*delroot-wroot, space-wpart+lroot+2*delroot+wroot ) to (wpart+lroot +2*delroot-wroot-lroot, space-wpart+lroot+2*delroot+wroot-lroot) to close
  REGION 'Titanium Holder 1'
cond= 21 !W/mK
Start (wpart, space-wpart) line to (wpart+handroot, space-wpart-handroot) to (wpart+delroot+troot+sroot+proot+bendroot, space-wpart-handroot+bendroot) to (wpart+delroot+troot+sroot+proot+bendroot-thickroot, space-wpart-handroot+bendroot+thickroot)  to (wpart+delroot+troot+sroot+proot, space-wpart+delroot-troot-sroot-proot-heroot-caseinroot-coldcaseroot-vacroot-caseoutroot) to (wpart+thickroot, space-wpart+thickroot) to close
  REGION 'Titanium Holder 2'
cond=21 !W/mK
start (wpart+lengthroot,space-wpart+lengthroot) line to (wpart+delroot+troot+croot+sroot+proot+heroot+caseinroot+coldcaseroot+vacroot+caseoutroot, space-wpart+delroot-troot+croot-sroot-proot)  to (wpart+delroot+troot+croot+sroot+proot+heroot+caseinroot+coldcaseroot+vacroot+caseoutroot-bendroot+thickroot, space-wpart+delroot-troot+croot-sroot-proot-bendroot+thickroot) to (wpart+delroot+troot+croot+sroot+proot+heroot+caseinroot+coldcaseroot+vacroot+caseoutroot-bendroot+2*thickroot, space-wpart+delroot-troot+croot-sroot-proot-bendroot) to (wpart+delroot+troot+croot+sroot+proot+heroot+caseinroot+coldcaseroot+vacroot+caseoutroot-bendroot+2*thickroot+bendroot, space-wpart+delroot-troot+croot-sroot-proot-bendroot+bendroot) to (wpart+lengthroot+thickroot, space-wpart+lengthroot+thickroot) to close 
  REGION 'Case Outside'
cond=9
Start (wpart+delroot+sroot+proot-heroot-caseinroot-coldcaseroot-vacroot-caseoutroot, space-wpart+delroot-sroot-proot) line to (wpart+delroot+troot+sroot+proot, space-wpart+delroot-troot-sroot-proot-heroot-caseinroot-coldcaseroot-vacroot-caseoutroot) to (wpart+delroot+troot+croot+sroot+proot+heroot+caseinroot+coldcaseroot+vacroot+caseoutroot, space-wpart+delroot-troot+croot-sroot-proot) 
to (wpart+delroot+croot+sroot+proot, space-wpart+delroot+croot-sroot-proot+heroot+caseinroot+coldcaseroot+vacroot+caseoutroot)  to close
  !REGION 'Vacuum'
!Start (wpart+delroot+sroot+proot-heroot-caseinroot-coldcaseroot-vacroot, r/2-wpart+delroot-sroot-proot) line to (wpart+delroot+troot+sroot+proot, r/2-wpart+delroot-troot-sroot-proot-heroot-caseinroot-coldcaseroot-vacroot) to (wpart+delroot+troot+croot+sroot+proot+heroot+caseinroot+coldcaseroot+vacroot, r/2-wpart+delroot-troot+croot-sroot-proot) 
!to (wpart+delroot+croot+sroot+proot, r/2-wpart+delroot+croot-sroot-proot+heroot+caseinroot+coldcaseroot+vacroot)  to close
  !REGION 'Cold Case'
!Start (wpart+delroot+sroot+proot-heroot-caseinroot-coldcaseroot, r/2-wpart+delroot-sroot-proot) line to (wpart+delroot+troot+sroot+proot, r/2-wpart+delroot-troot-sroot-proot-heroot-caseinroot-coldcaseroot) to (wpart+delroot+troot+croot+sroot+proot+heroot+caseinroot+coldcaseroot, r/2-wpart+delroot-troot+croot-sroot-proot) 
!to (wpart+delroot+croot+sroot+proot, r/2-wpart+delroot+croot-sroot-proot+heroot+caseinroot+coldcaseroot)  to close
 ! REGION 'Case Inside'
!Start (wpart+delroot+sroot+proot-heroot-caseinroot, r/2-wpart+delroot-sroot-proot) line to (wpart+delroot+troot+sroot+proot, r/2-wpart+delroot-troot-sroot-proot-heroot-caseinroot) to (wpart+delroot+troot+croot+sroot+proot+heroot+caseinroot, r/2-wpart+delroot-troot+croot-sroot-proot) 
!to (wpart+delroot+croot+sroot+proot, r/2-wpart+delroot+croot-sroot-proot+heroot+caseinroot)  to close
  REGION 'Nitrogen'
cond= 0.02604 !W/mK
Start (wpart+delroot+sroot+proot-heroot, space-wpart+delroot-sroot-proot) value(Temp)=Tempcold line to (wpart+delroot+troot+sroot+proot, space-wpart+delroot-troot-sroot-proot-heroot) value(Temp)=Tempcold line to (wpart+delroot+troot+croot+sroot+proot+heroot, space-wpart+delroot-troot+croot-sroot-proot) 
value(Temp)=Tempcold line to (wpart+delroot+croot+sroot+proot, space-wpart+delroot+croot-sroot-proot+heroot) value(Temp)=Tempcold line to close
  REGION 'Coil Tape 1'
cond= 10
!J=Jcoil
Start (wpart+delroot+sroot+proot, space-wpart+delroot-sroot-proot) natural(Temp)= Tempcold line to (wpart+delroot+troot+sroot+proot, space-wpart+delroot-troot-sroot-proot) naTURAL(Temp)=Tempcold line to (wpart+delroot+troot+croot+sroot+proot, space-wpart+delroot-troot+croot-sroot-proot) NATURAL(Temp)=Tempcold
line to (wpart+delroot+croot+sroot+proot, space-wpart+delroot+croot-sroot-proot) natural(Temp)=Tempcold line to close

! TIME 0 TO 1    { if time dependent }
MONITORS         { show progress }
PLOTS            { save result displays }
  CONTOUR(Temp) painted
  CONTOUR(Temp)
  VECTOR(-COND*GRAD(Temp))
  ELEVATION(Temp) from (0,0+5*t) to (rspace+d,rspace+d+5*t)
  
END

