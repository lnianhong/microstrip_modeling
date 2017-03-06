.subckt cpw a b p len=220u width=4.4u space=4.4u scale=0.90909090909091
*
.param
*
+ l = '(len*scale)'
+ w = '(len*scale)*1e6'
+ s = '(len*scale)*1e6'
*
*
+ R0_unit = '((2.235403606119741e-1)*(s**3)+(-3.939974671659244)*(s**2)+(1.937320438194369e1)*s+(-2.843880443031134e1))*(w**3)+((-4.683978126140169)*(s**3)+(8.240421221749442e1)*(s**2)+(-4.028244514817184e2)*s+(6.093146889001549e2))*(w**2)+((3.204910161089811e1)*(s**3)+(-5.629915350112353e2)*(s**2)+(2.742807145053426e3)*s+(-4.441432208277684e3))*w+((-7.231383150113504e1)*(s**3)+(1.269856426113886e3)*(s**2)+(-6.214947080889494e3)*s+(1.263619562322674e4))'
+ R1_unit = '((1.539079383751155e-2)*(s**3)+(-3.869778469442355e-1)*(s**2)+(2.193686498798849)*s+(-4.838249022123454))*(w**3)+((-9.096486726115907e-1)*(s**3)+(1.854958090081239e1)*(s**2)+(-1.000997581718307e2)*s+(1.814482045408992e2))*(w**2)+((1.017263622667340e1)*(s**3)+(-1.953127747749391e2)*(s**2)+(1.027339673223940e3)*s+(-1.712807806741118e3))*w+((-3.084064252406546e1)*(s**3)+(5.775132564521377e2)*(s**2)+(-3.037028371959976e3)*s+(5.224707764521395e3))'
+ R2_unit = '((-1.218679271213956)*(s**3)+(2.015035698802241e1)*(s**2)+(-1.012688843326159e2)*s+(1.625733480201229e2))*(w**3)+((2.262077074329190e1)*(s**3)+(-3.764562376554823e2)*(s**2)+(1.921323938108619e3)*s+(-3.193596786783605e3))*(w**2)+((-1.363027083135099e2)*(s**3)+(2.298113111035553e3)*(s**2)+(-1.201543943594019e4)*s+(2.068129779956507e4))*w+((2.691438657324410e2)*(s**3)+(-4.589566472483577e3)*(s**2)+(2.443222186575891e4)*s+(-3.819782822316189e4))'
+ R3_unit = '((1.592282989149042e-1)*(s**3)+(1.789031583475565)*(s**2)+(-1.753889619921636e1)*s+(-2.676588940824397e1))*(w**3)+((9.017605964135910)*(s**3)+(-2.456414259044378e2)*(s**2)+(1.373569809085317e3)*s+(-6.807920901407323e2))*(w**2)+((-1.470458121498002e2)*(s**3)+(3.077385087469129e3)*(s**2)+(-1.589841697439813e4)*s+(1.221381333300672e4))*w+((5.075647028743248e2)*(s**3)+(-9.777120855984196e3)*(s**2)+(4.916219645153591e4)*s+(-3.797202694922340e4))'
+ L0_unit = '((4.811457179197244e-12)*(s**3)+(-8.410787758151274e-11)*(s**2)+(3.702216366937209e-10)*s+(-2.838521897433635e-10))*(w**3)+((-1.194460646529774e-10)*(s**3)+(2.083537228828540e-9)*(s**2)+(-9.114994044350209e-9)*s+(7.543563834986730e-9))*(w**2)+((9.558524642762987e-10)*(s**3)+(-1.646640667116367e-8)*(s**2)+(6.976577635876885e-8)*s+(-6.444211274657358e-8))*w+((-2.340771124661845e-9)*(s**3)+(3.785337686675333e-8)*(s**2)+(-1.094313216030978e-7)*s+(2.572729405624954e-7))'
+ L1_unit = '((2.449520164954098e-12)*(s**3)+(-6.158942833659943e-11)*(s**2)+(3.491360259257873e-10)*s+(-7.700311649119006e-10))*(w**3)+((-1.447750676225720e-10)*(s**3)+(2.952257329103129e-9)*(s**2)+(-1.593137090767939e-8)*s+(2.887837713848482e-8))*(w**2)+((1.619025242017593e-9)*(s**3)+(-3.108499259003965e-8)*(s**2)+(1.635061849689077e-7)*s+(-2.726018199796096e-7))*w+((-4.908440504078255e-9)*(s**3)+(9.191408763291133e-8)*(s**2)+(-4.833580736213604e-7)*s+(8.315380497554077e-7))'
+ L2_unit = '((5.118588372292632e-12)*(s**3)+(-9.660285678176695e-11)*(s**2)+(5.335341200517194e-10)*s+(-8.008121109755907e-10))*(w**3)+((-7.990795355891847e-11)*(s**3)+(1.517103838868320e-9)*(s**2)+(-8.442595977484407e-9)*s+(1.257126633968775e-8))*(w**2)+((3.489603427771390e-10)*(s**3)+(-6.802477760586100e-9)*(s**2)+(3.905075523010496e-8)*s+(-5.821049882202427e-8))*w+((-3.691315156023844e-10)*(s**3)+(7.955025548248235e-9)*(s**2)+(-4.998427708417236e-8)*s+(1.105220540780333e-7))'
+ L3_unit = '((2.534197371982760e-13)*(s**3)+(2.847333722138000e-12)*(s**2)+(-2.791401919645033e-11)*s+(-4.259923543991570e-11))*(w**3)+((1.435196499618273e-11)*(s**3)+(-3.909505051540986e-10)*(s**2)+(2.186104229208377e-9)*s+(-1.083514278216076e-9))*(w**2)+((-2.340306739095667e-10)*(s**3)+(4.897810718024167e-9)*(s**2)+(-2.530311637830531e-8)*s+(1.943888776751200e-8))*w+((8.078143026098304e-10)*(s**3)+(-1.556077163073451e-8)*(s**2)+(7.824406557262333e-8)*s+(-6.043435812544096e-8))'
+ G0_unit = '((6.672879325522297e-6)*(s**3)+(-1.205023914897125e-4)*(s**2)+(6.705031844975570e-4)*s+(-1.090625157789625e-3))*(w**3)+((-1.260806310468924e-4)*(s**3)+(2.315233688687456e-3)*(s**2)+(-1.308804209561210e-2)*s+(2.165946025403893e-2))*(w**2)+((7.561442893417812e-4)*(s**3)+(-1.409548114345577e-2)*(s**2)+(8.083510138213297e-2)*s+(-1.351155586817375e-1))*w+((-1.399050673311893e-3)*(s**3)+(2.632903098455488e-2)*(s**2)+(-1.521225683807742e-1)*s+(2.576334676508728e-1))'
+ G1_unit = '((-1.321315585825063e-5)*(s**3)+(2.394130362729574e-4)*(s**2)+(-1.335543533879213e-3)*s+(2.165794078864088e-3))*(w**3)+((2.483052777112337e-4)*(s**3)+(-4.577551029374306e-3)*(s**2)+(2.596021242110121e-2)*s+(-4.267392263411619e-2))*(w**2)+((-1.478179604192816e-3)*(s**3)+(2.767049709950512e-2)*(s**2)+(-1.587542892320019e-1)*s+(2.648352163783131e-1))*w+((2.701353946286921e-3)*(s**3)+(-5.104082599797537e-2)*(s**2)+(2.973539457680242e-1)*s+(-5.059347990740908e-1))'
+ G2_unit = '((-1.642879037936691e-4)*(s**3)+(3.289386162425657e-3)*(s**2)+(-2.010575583049971e-2)*s+(3.558035209159904e-2))*(w**3)+((3.300166916071689e-3)*(s**3)+(-6.666401486159820e-2)*(s**2)+(4.104996004421306e-1)*s+(-7.309302971651940e-1))*(w**2)+((-2.029895683285223e-2)*(s**3)+(4.135334188445988e-1)*(s**2)+(-2.559899619319151)*s+(4.699254601717141))*w+((3.663610173892246e-2)*(s**3)+(-7.581607682776795e-1)*(s**2)+(4.880030990745596)*s+(-9.314483425712574))'
+ G3_unit = '((3.149513494023923e-4)*(s**3)+(-6.438011540303250e-3)*(s**2)+(4.028101274115269e-2)*s+(-7.398550244320555e-2))*(w**3)+((-6.544532375294913e-3)*(s**3)+(1.346071873552324e-1)*(s**2)+(-8.477714619013533e-1)*s+(1.573469541104844))*(w**2)+((4.246017772386455e-2)*(s**3)+(-8.785232188054345e-1)*(s**2)+(5.571885355205207)*s+(-1.043637925398139e1))*w+((-8.979270340455837e-2)*(s**3)+(1.879407921907835)*(s**2)+(-1.217978613688453e1)*s+(2.391718577969095e1))'
+ C0_unit = '((3.426496912188261e-16)*(s**3)+(-7.254787392299159e-15)*(s**2)+(4.160205390339463e-14)*s+(-4.192923364516845e-14))*(w**3)+((-1.134751766328614e-15)*(s**3)+(4.574673023636931e-14)*(s**2)+(-2.961911739763227e-13)*s+(-1.881214728540999e-13))*(w**2)+((-3.921627412926724e-14)*(s**3)+(5.672462425753200e-13)*(s**2)+(-3.395938875111174e-12)*s+(1.787152041617522e-11))*w+((-3.759524675480017e-13)*(s**3)+(9.920143045698580e-12)*(s**2)+(-8.751820988840686e-11)*s+(3.495035099460037e-10))'
+ C1_unit = '((-2.102939062948762e-15)*(s**3)+(3.810376804438168e-14)*(s**2)+(-2.125583544550980e-13)*s+(3.446968322555792e-13))*(w**3)+((3.951901222520586e-14)*(s**3)+(-7.285398711049475e-13)*(s**2)+(4.131696116466539e-12)*s+(-6.791765705062645e-12))*(w**2)+((-2.352595900179821e-13)*(s**3)+(4.403896374997368e-12)*(s**2)+(-2.526652977604529e-11)*s+(4.214983363789120e-11))*w+((4.299338320262720e-13)*(s**3)+(-8.123399723742859e-12)*(s**2)+(4.732535012651210e-11)*s+(-8.052202383602438e-11))'
+ C2_unit = '((-9.039127941039946e-16)*(s**3)+(1.872563543046315e-14)*(s**2)+(-1.139750946832947e-13)*s+(1.966385394934118e-13))*(w**3)+((1.777813749690182e-14)*(s**3)+(-3.699026923610823e-13)*(s**2)+(2.261326382832815e-12)*s+(-3.851421124130432e-12))*(w**2)+((-1.053857502004117e-13)*(s**3)+(2.201744343981411e-12)*(s**2)+(-1.331695931536596e-11)*s+(2.399028684048967e-11))*w+((1.782415933770826e-13)*(s**3)+(-3.797653947666483e-12)*(s**2)+(2.494752375878356e-11)*s+(-4.822221792651566e-11))'
+ C3_unit = '((5.012606668612842e-16)*(s**3)+(-1.024641361652009e-14)*(s**2)+(6.410922296885153e-14)*s+(-1.177515843365038e-13))*(w**3)+((-1.041594735960390e-14)*(s**3)+(2.142339927439736e-13)*(s**2)+(-1.349270189238124e-12)*s+(2.504254553351347e-12))*(w**2)+((6.757747584401037e-14)*(s**3)+(-1.398213131298575e-12)*(s**2)+(8.867930977663836e-12)*s+(-1.661001346748439e-11))*w+((-1.429095351701297e-13)*(s**3)+(2.991170614321958e-12)*(s**2)+(-1.938473172297139e-11)*s+(3.806538342934514e-11))'
*
+ R0  = 'l*R0_unit/4'
+ R1  = 'l*R1_unit/4'
+ R2  = 'l*R2_unit/4'
+ R3  = 'l*R3_unit/4'
+ L0  = 'l*L0_unit/4'
+ L1  = 'l*L1_unit/4'
+ L2  = 'l*L2_unit/4'
+ L3  = 'l*L3_unit/4'
+ RG0 = '4/(l*G0_unit)'
+ RG1 = '4/(l*G1_unit)'
+ RG2 = '4/(l*G2_unit)'
+ RG3 = '4/(l*G3_unit)'
+ C0  = 'l*C0_unit/4'
+ C1  = 'l*C1_unit/4'
+ C2  = 'l*C2_unit/4'
+ C3  = 'l*C3_unit/4'
*
*
*
*******************************************************
******                  Netlist                  ******
*******************************************************
RG010      		a          		p          		'2*RG0'
C010       		a          		p          		'0.5*C0'
RG011      		a          		np011      		'2*RG1'
C011       		np011      		p          		'0.5*C1'
RG012      		a          		np012      		'2*RG2'
C012       		np012      		p          		'0.5*C2'
RG013      		a          		np013      		'2*RG3'
C013       		np013      		p          		'0.5*C3'
R010       		a          		ns011      		'R0'
L010       		ns011      		ns012      		'L0'
R011       		ns012      		ns013      		'R1'
L011       		ns012      		ns013      		'L1'
R012       		ns013      		ns014      		'R2'
L012       		ns013      		ns014      		'L2'
R013       		ns014      		ns015      		'R3'
L013       		ns014      		ns015      		'L3'
RG020      		ns015      		p          		'RG0'
C020       		ns015      		p          		'C0'
RG021      		ns015      		np021      		'RG1'
C021       		np021      		p          		'C1'
RG022      		ns015      		np022      		'RG2'
C022       		np022      		p          		'C2'
RG023      		ns015      		np023      		'RG3'
C023       		np023      		p          		'C3'
R020       		ns015      		ns021      		'R0'
L020       		ns021      		ns022      		'L0'
R021       		ns022      		ns023      		'R1'
L021       		ns022      		ns023      		'L1'
R022       		ns023      		ns024      		'R2'
L022       		ns023      		ns024      		'L2'
R023       		ns024      		ns025      		'R3'
L023       		ns024      		ns025      		'L3'
RG030      		ns025      		p          		'RG0'
C030       		ns025      		p          		'C0'
RG031      		ns025      		np031      		'RG1'
C031       		np031      		p          		'C1'
RG032      		ns025      		np032      		'RG2'
C032       		np032      		p          		'C2'
RG033      		ns025      		np033      		'RG3'
C033       		np033      		p          		'C3'
R030       		ns025      		ns031      		'R0'
L030       		ns031      		ns032      		'L0'
R031       		ns032      		ns033      		'R1'
L031       		ns032      		ns033      		'L1'
R032       		ns033      		ns034      		'R2'
L032       		ns033      		ns034      		'L2'
R033       		ns034      		ns035      		'R3'
L033       		ns034      		ns035      		'L3'
RG040      		ns035      		p          		'RG0'
C040       		ns035      		p          		'C0'
RG041      		ns035      		np041      		'RG1'
C041       		np041      		p          		'C1'
RG042      		ns035      		np042      		'RG2'
C042       		np042      		p          		'C2'
RG043      		ns035      		np043      		'RG3'
C043       		np043      		p          		'C3'
R040       		ns035      		ns041      		'R0'
L040       		ns041      		ns042      		'L0'
R041       		ns042      		ns043      		'R1'
L041       		ns042      		ns043      		'L1'
R042       		ns043      		ns044      		'R2'
L042       		ns043      		ns044      		'L2'
R043       		ns044      		b          		'R3'
L043       		ns044      		b          		'L3'
RG050      		b          		p          		'2*RG0'
C050       		b          		p          		'0.5*C0'
RG051      		b          		np051      		'2*RG1'
C051       		np051      		p          		'0.5*C1'
RG052      		b          		np052      		'2*RG2'
C052       		np052      		p          		'0.5*C2'
RG053      		b          		np053      		'2*RG3'
C053       		np053      		p          		'0.5*C3'
*
.ends cpw