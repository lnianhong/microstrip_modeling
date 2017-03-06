.Title test_cpw
.include 'E:\microstrip_modeling\GCPW_modeling\Modeling_of_GCPW_v1\hspice_project\cpw\cpw.sp'
.option post=1 runlvl=6
.temp 27
x1 a b 0 cpw len=385.00u width=7.70u space=8.80u
P1 a 0 port=1  z0=50
P2 b 0 port=2  z0=50
* Measure s-parameters
.AC LIN 200 0.5G 100G
.LIN sparcalc=1 modelname=test_cpw filename=test_cpw format=selem dataformat=ri SPARDIGIT=15
.PRINT S11(R) S11(I) S21(R) S21(I) S12(R) S12(I) S22(R) S22(I)
.end
