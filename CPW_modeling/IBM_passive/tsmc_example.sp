.subckt sline_ms_mu a b p w=3u s=6u l=400u lay=10 scale='scale_rftl'

.param

+ Lt='(16.8159998398701*((w*scale)*1e6)**(-0.715947268229622)+6.87810959752728*((s*scale)*1e6)**(0.520203209577693)-0.00933099916847061*((w*scale)*1e6)*((s*scale)*1e6)**(1.16915408785086)-0.132970402408837*((s*scale)/(w*scale))**(1.22428851554783))*1e-12'

+ Ls='(9.20269451869425*((w*scale)*1e6)**(-1.17549526385809)+0.724917043906978*((s*scale)*1e6)**(0.590082840879492)-0.439498547882149*((w*scale)*1e6)*((s*scale)*1e6)**(-0.348095776758987)+4.63903472394479*((s*scale)/(w*scale))**(-0.409309333148923))*1e-12'

+ Rt='0.044342509975455*((w*scale)*1e6)**(0.659456266057975)+0.00954647873491933*((s*scale)*1e6)**(1.36628384199879)-0.000126412526403203*((w*scale)*1e6)*((s*scale)*1e6)**(1.72119504783997)-2.300810885343e-11*((s*scale)/(w*scale))**(5.7582323167587)'

+ Rs='0.390049819*((w*scale)*1e6)**(-0.69346048)+0.964100954*((s*scale)*1e6)**(-1.611131375)+1.44e-05*((w*scale)*1e6)*((s*scale)*1e6)**(0.984798224)-5.44e-06*((s*scale)/(w*scale))**(1.967039013)'

+ Cox='(181.1046595*((s*scale)*1e6)**(-2.302041201)+0.58686796*((w*scale)*1e6)*((s*scale)*1e6)**(-9.28e-02)+5.470681886*((s*scale)/(w*scale))**(1.60e-02))*1e-15'

+ Csub='(2.753256787*((w*scale)*1e6)**(0.277685792)+47.10773306*((s*scale)*1e6)**(-1.73072674)+0.881083046*((w*scale)*1e6)*((s*scale)*1e6)**(-0.276356422)-8.917060501*((s*scale)/(w*scale))**(-0.482059977))*1e-15'

+ Rsub='250*1e3'

*

*

L1     a       3       'Lt/(300u)*(l*scale)*l_tlfac'

R1    3       4       'Rt/(300u)*(l*scale)*rm_tlfac'

LS1   3       11     'Ls/(300u)*(l*scale)'

RS1  11     4       'Rs/(300u)*(l*scale)'

COX1        4       p       'Cox/(300u)*(l*scale)*cox_tlfac'

 

L2     4       5       'Lt/(300u)*(l*scale)*l_tlfac'

R2    5       6       'Rt/(300u)*(l*scale)*rm_tlfac'

LS2   5       12     'Ls/(300u)*(l*scale)'

RS2  12     6       'Rs/(300u)*(l*scale)'

COX2        6       p       'Cox/(300u)*(l*scale)*cox_tlfac'

 

COX3        6       p       'Cox/(300u)*(l*scale)*cox_tlfac'

R3    6       7       'Rt/(300u)*(l*scale)*rm_tlfac'

RS3  6       13     'Rs/(300u)*(l*scale)'

LS3   13     7       'Ls/(300u)*(l*scale)'

L3     7       8       'Lt/(300u)*(l*scale)*l_tlfac'

 

COX4        8       p       'Cox/(300u)*(l*scale)*cox_tlfac'

R4    8       9       'Rt/(300u)*(l*scale)*rm_tlfac'

RS4  8       14     'Rs/(300u)*(l*scale)'

LS4   14     9       'Ls/(300u)*(l*scale)'

L4     9       b       'Lt/(300u)*(l*scale)*l_tlfac'

 

CSUB1      4       15     'Csub/(300u)*(l*scale)*csub_tlfac'

RSUB1      15     p       'Rsub*300u/(l*scale)*rsub_tlfac'

CSUB2      6       16     'Csub/(300u)*(l*scale)*csub_tlfac'

RSUB2      16     p       'Rsub*300u/(l*scale)*rsub_tlfac'

CSUB3      6       17     'Csub/(300u)*(l*scale)*csub_tlfac'    

RSUB3      17     p       'Rsub*300u/(l*scale)*rsub_tlfac'

CSUB4      8       18     'Csub/(300u)*(l*scale)*csub_tlfac'

RSUB4      18     p       'Rsub*300u/(l*scale)*rsub_tlfac'

.ends sline_ms_mu
