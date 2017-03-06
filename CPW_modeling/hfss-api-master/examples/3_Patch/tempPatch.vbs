Dim oHfssApp
Dim oDesktop
Dim oProject
Dim oDesign
Dim oEditor
Dim oModule

Set oHfssApp  = CreateObject("AnsoftHfss.HfssScriptInterface")
Set oDesktop = oHfssApp.GetAppDesktop()
oDesktop.RestoreWindow
oDesktop.NewProject
Set oProject = oDesktop.GetActiveProject

oProject.InsertDesign "HFSS", "NxN_uStrip_Patch", "DrivenModal", ""
Set oDesign = oProject.SetActiveDesign("NxN_uStrip_Patch")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "-0.012000meter", _
"YStart:=", "-0.012000meter", _
"ZStart:=", "0.000000meter", _
"Width:=", "0.024000meter", _
"Height:=", "0.024000meter", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "Patch", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-01, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "-0.012000meter", _
"YStart:=", "-0.002540meter", _
"ZStart:=", "0.000000meter", _
"Width:=", "-0.004000meter", _
"Height:=", "0.005080meter", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "Feed", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-01, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.Unite  _
Array("NAME:Selections", _
"Selections:=", "Patch,Feed"), _
Array("NAME:UniteParameters", "KeepOriginals:=", false)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignPerfectE _
Array("NAME:PatchMetal", _
"Objects:=", _
Array("Patch"), _ 
"InfGroundPlane:=", false _ 
)

oEditor.ChangeProperty _
	Array("NAME:AllTabs", _
		Array("NAME:Geometry3DAttributeTab", _
			Array("NAME:PropServers", "Patch"), _
			Array("NAME:ChangedProps",  _
				Array("NAME:Color", "R:=", 128, "G:=", 128, "B:=", 0) _
			) _
		) _
	) 

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
	Array("NAME:Geometry3DAttributeTab", _
		Array("NAME:PropServers","Patch"), _
		Array("NAME:ChangedProps", _
			Array("NAME:Transparent", "Value:=",  0.000000) _
			) _
		) _
	)

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "-0.016000meter", _
"YStart:=", "-0.002540meter", _
"ZStart:=", "0.000000meter", _
"Width:=", "0.005080meter", _
"Height:=", "-0.001524meter", _
"WhichAxis:=", "X"), _
Array("NAME:Attributes", _
"Name:=", "Port", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-01, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignLumpedPort _
Array("NAME:LPort", _
      Array("NAME:Modes", _
             Array("NAME:Mode1", _
                   "ModeNum:=", 1, _
                   "UseIntLine:=", true, _
                   Array("NAME:IntLine", _
                          "Start:=", Array("-0.016000meter", "0.000000meter", "0.000000meter"), _
                          "End:=",   Array("-0.016000meter", "0.000000meter", "-0.001524meter") _
                         ), _
                   "CharImp:=", "Zpi" _
                   ) _
            ), _
      "Resistance:=", "50.000000Ohm", _
      "Reactance:=", "0.000000Ohm", _
      "Objects:=", Array("Port") _
      )

oEditor.CreateBox _
Array("NAME:BoxParameters", _
"XPosition:=", "-0.100000meter", _
"YPosition:=", "-0.120000meter", _
"ZPosition:=", "0.000000meter", _
"XSize:=", "0.200000meter", _
"YSize:=", "0.240000meter", _
"ZSize:=", "-0.001524meter"), _
Array("NAME:Attributes", _
"Name:=", "Substrate", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0.75, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.AssignMaterial _
	Array("NAME:Selections", _
		"Selections:=", "Substrate"), _
	Array("NAME:Attributes", _
		"MaterialName:=", "Rogers RT/duroid 5880 (tm)", _
		"SolveInside:=", true)

oEditor.ChangeProperty _
	Array("NAME:AllTabs", _
		Array("NAME:Geometry3DAttributeTab", _
			Array("NAME:PropServers", "Substrate"), _
			Array("NAME:ChangedProps",  _
				Array("NAME:Color", "R:=", 0, "G:=", 128, "B:=", 0) _
			) _
		) _
	) 

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
	Array("NAME:Geometry3DAttributeTab", _
		Array("NAME:PropServers","Substrate"), _
		Array("NAME:ChangedProps", _
			Array("NAME:Transparent", "Value:=",  0.200000) _
			) _
		) _
	)

oEditor.Move _
Array("NAME:Selections", _
"Selections:=", "Patch,Port"), _
Array("NAME:TranslateParameters", _
"TranslateVectorX:=", "-0.060000meter", _
"TranslateVectorY:=", "0.000000meter", _
"TranslateVectorZ:=", "0.000000meter")

oEditor.DuplicateAlongLine _
Array("NAME:Selections", _
"Selections:=", "Patch,Port"), _
Array("NAME:DuplicateToAlongLineParameters", _
"XComponent:=", "0.040000meter", _
"YComponent:=", "0.000000meter", _
"ZComponent:=", "0.000000meter", _
"NumClones:=", 4), _
Array("NAME:Options", _
"DuplicateBoundaries:=", true)

oEditor.Move _
Array("NAME:Selections", _
"Selections:=", "Patch,Patch_1,Patch_2,Patch_3,Patch_4,Port,Port_1,Port_2,Port_3,Port_4"), _
Array("NAME:TranslateParameters", _
"TranslateVectorX:=", "0.000000meter", _
"TranslateVectorY:=", "-0.080000meter", _
"TranslateVectorZ:=", "0.000000meter")

oEditor.DuplicateAlongLine _
Array("NAME:Selections", _
"Selections:=", "Patch,Patch_1,Patch_2,Patch_3,Patch_4,Port,Port_1,Port_2,Port_3,Port_4"), _
Array("NAME:DuplicateToAlongLineParameters", _
"XComponent:=", "0.000000meter", _
"YComponent:=", "0.040000meter", _
"ZComponent:=", "0.000000meter", _
"NumClones:=", 5), _
Array("NAME:Options", _
"DuplicateBoundaries:=", true)

oEditor.CreateBox _
Array("NAME:BoxParameters", _
"XPosition:=", "-0.100000meter", _
"YPosition:=", "-0.120000meter", _
"ZPosition:=", "-0.001524meter", _
"XSize:=", "0.200000meter", _
"YSize:=", "0.240000meter", _
"ZSize:=", "0.021524meter"), _
Array("NAME:Attributes", _
"Name:=", "AirBox", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0.75, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignRadiation _
Array("NAME:ABC", _
"Objects:=", Array("AirBox"), _
"UseAdaptiveIE:=", false)

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
	Array("NAME:Geometry3DAttributeTab", _
		Array("NAME:PropServers","AirBox"), _
		Array("NAME:ChangedProps", _
			Array("NAME:Transparent", "Value:=",  0.950000) _
			) _
		) _
	)

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "-0.100000meter", _
"YStart:=", "-0.120000meter", _
"ZStart:=", "-0.001524meter", _
"Width:=", "0.200000meter", _
"Height:=", "0.240000meter", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "GroundPlane", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-01, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignPerfectE _
Array("NAME:GND", _
"Faces:=", _
Array(GroundPlane), _ 
"InfGroundPlane:=", false _ 
)

Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.InsertSetup "HfssDriven", _
Array("NAME:Setup3_75GHz", _
"Frequency:=", "3.750000GHz", _
"PortsOnly:=", false, _
"maxDeltaS:=", 0.020000, _
"UseMatrixConv:=", false, _
"MaximumPasses:=", 25, _
"MinimumPasses:=", 1, _
"MinimumConvergedPasses:=", 1, _
"PercentRefinement:=", 20, _
"ReducedSolutionBasis:=", false, _
"DoLambdaRefine:=", true, _
"DoMaterialLambda:=", true, _
"Target:=", 0.3333, _
"PortAccuracy:=", 2, _
"SetPortMinMaxTri:=", false)

Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.InsertDrivenSweep _
"Setup3_75GHz", _
Array("NAME:Sweep3to4_5GHz", _
"Type:=", "Interpolating", _
"InterpTolerance:=", 0.500000, _
"InterpMaxSolns:=", 101, _
"SetupType:=", "LinearCount", _
"StartFreq:=", "3.000000GHz", _
"StopFreq:=", "4.500000GHz", _
"Count:=", 1001, _
"SaveFields:=", false, _
"ExtrapToDC:=", false)

oProject.SaveAs _
    "E:\研究生期间2015-2018\研究生课程学习\微带线建模\hfss-api-master\examples\3_Patch\tmpMicrowavePatch.hfss", _
    true
