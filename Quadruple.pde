{ Fill in the following sections (removing comment marks ! if necessary),
  and delete those that are unused.}
TITLE 'Quadruple'     { the problem identification }
COORDINATES cartesian2  { coordinate system, 1D,2D,3D, etc }
VARIABLES        { system variables }
A              { choose your own names }
! SELECT         { method controls }
DEFINITIONS    { parameter definitions }

b=curl(A)
r=0.6 !m
d=0.4 !m
l=0.3 !m
lroot=l/sqrt(2) !m
w=0.3 !m
wpart=w/(2*sqrt(2)) !m
wroot=w/sqrt(2) !m
t=0.05 !m
TROOT=T/SQRT(2)
c=0.2 !m
CROOT=C/SQRT(2)
DELTA=0.06
DELROOT=DELTA/SQRT(2)
J=0
mu0=4*pi*1e-7
mur=1
mu=mu0*mur
muiron=1+1507*exp(-magnitude(b)/1.443)^3.725
Jcoil=1e6
magB=magnitude(b)
v=vector(dx(magB), dy(magB))
! This is to determine the Lorentz forces
Bex=dy(A)
Bey=-dx(A)
Bef=vector(Bex,Bey) 
Bem=magnitude(Bef)
Hx=Bex/mu
Hy=Bey/mu
H=Bef/mu
Hm=Bem/mu

! INITIAL VALUES
EQUATIONS        { PDE's, one for each variable }
curl(1/mu*curl(A))=J
! CONSTRAINTS    { Integral constraints }
BOUNDARIES       { The domain definition }
  REGION 'Air'
START(0,0) natural(A)=0 LINE TO (2,0) value(A)=0 line TO  (2,2) value(A)=0 line tO (0,2) natural(A)=0 line to CLOSE
  REGION 'Soft Iron'       { For each material region }
mur=muiron
    START(0,r)   { Walk the domain boundary }
    LINE TO (0,r+d) TO (r+d,r+d) TO (r+d,0) TO (r,0) to (r,r/2) to (r-r/4+wpart, r/2+r/4-wpart) to (r-r/4+wpart-lroot, r/2+r/4-wpart-lroot) to (r-r/4+wpart-lroot-wroot, r/2+r/4-wpart-lroot+wroot) to (r/2+r/4-wpart, r-r/4+wpart) to (r/2,r) to CLOSE
   REGION 'Coil Tape 1'
J=Jcoil
START(r-r/4+wpart-lroot+DELROOT, r/2+r/4-wpart-lroot+DELROOT) LINE TO (r-r/4+wpart-lroot+DELROOT+TROOT, r/2+r/4-wpart-lroot+DELROOT-TROOT) TO (r-r/4+wpart-lroot+DELROOT+TROOT+CROOT, r/2+r/4-wpart-lroot+DELROOT-TROOT+CROOT) TO (r-r/4+wpart-lroot+DELROOT+TROOT+CROOT-DELROOT, r/2+r/4-wpart-lroot+DELROOT+CROOT) TO CLOSE
   REGION 'Coil Tape 2'
J=-Jcoil
START(R/2+R/4-WPART-LROOT+DELROOT,R-R/4+WPART-LROOT+DELROOT) LINE TO (R/2+R/4-WPART-LROOT+DELROOT-TROOT,R-R/4+WPART-LROOT+DELROOT+TROOT) TO (R/2+R/4-WPART-LROOT+DELROOT-TROOT+CROOT,R-R/4+WPART-LROOT+DELROOT+TROOT+CROOT) TO (R/2+R/4-WPART-LROOT+DELROOT+CROOT,R-R/4+WPART-LROOT+DELROOT+CROOT) TO CLOSE

! TIME 0 TO 1    { if time dependent }
MONITORS         { show progress }
PLOTS            { save result displays }
 CONTOUR(A) PAINTED
 VECTOR(B)
 VECTOR(v) 
contour(A)
!Lorentz force
 CONTOUR(Bey) painted
   report(area_integral(J*Bex, 'Coil Tape 1')) as 'Force on Coil Tape 1'
   report(area_integral(J*Bex, 'Coil Tape 2')) as 'Force on Coil Tape 2'
 ELEVATION(V) FROM (0,0) TO (L,L)
 ELEVATION(B) FROM (0,0) TO (L,L)
END
