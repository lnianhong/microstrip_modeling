.Title test_cpw
.include 'E:\microstrip_modeling\CPW_modeling\Modeling_of_CPW_v11(2-D-SVDfit)\hspice_project\cpw\cpw.sp'
.option post=1 runlvl=6
.temp 27
x1 a b 0 cpw len=388.89u width=5.00u space=4.44u
P1 a 0 port=1  z0=50
P2 b 0 port=2  z0=50
* Measure s-parameters
.AC LIN 200 0.5G 100G
.LIN sparcalc=1 modelname=test_cpw filename=test_cpw format=selem dataformat=ri SPARDIGIT=15
.PRINT S11(R) S11(I) S21(R) S21(I) S12(R) S12(I) S22(R) S22(I)
.end
