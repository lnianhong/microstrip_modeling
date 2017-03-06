.Title test_unit_Sparam
.option post=1 runlvl=6 
.temp 27
RG b 0 2.58
C1 b 0 1.754e-10
R1 a c 5434
L1 c b 2.97e-7

P1 a 0 port=1  z0=50 
P2 b 0 port=2  z0=50
**
** Measure s-parameters 
**
.AC LIN 200 0.5G 100G
.LIN sparcalc=1 modelname=test_unit_Sparam filename=test_unit_Sparam format=selem dataformat=ri SPARDIGIT=15
.PRINT S11(R) S11(I) S21(R) S21(I) S12(R) S12(I) S22(R) S22(I)


.end