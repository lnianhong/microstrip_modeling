.Title test_cpw_Sparam
.include "E:/microstrip_modeling/Modeling_of_CPW_v11(2-D-SVDfit)\hspice_project\test_cpw\cpw.sp"

.option post=1 runlvl=6 
.temp 27

x1 a b 0 cpw len=220u width=4.4u space=4.4u
P1 a 0 port=1  z0=50 
P2 b 0 port=2  z0=50
**
** Measure s-parameters 
**
.AC LIN 200 0.5G 100G
.LIN sparcalc=1 modelname=test_cpw_Sparam filename=test_cpw_Sparam format=selem dataformat=ri SPARDIGIT=15
*.PRINT S11(DB) S21(DB) S12(DB) S22(DB) 
.PRINT S11(R) S11(I) S21(R) S21(I) S12(R) S12(I) S22(R) S22(I)
*.PROBE S11(R) S11(I) S21(R) S21(I) S12(R) S12(I) S22(R) S22(I)

.end