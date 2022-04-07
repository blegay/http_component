//%attributes = {"shared":false,"invisible":true}

  //Si (Non(Mode compile))
ARRAY TEXT:C222($tt_components;0)
COMPONENT LIST:C1001($tt_components)
If (Find in array:C230($tt_components;"dbg_component")>0)
	
	  //Initialize the http debug
	  //DBG_init 
	  //DBG_mode_OnOff (Vrai)
	
	  //DBG_module_Mode_Set ("http";Vrai)
	  //DBG_module_Threshold_Set ("http";8)
	
	EXECUTE METHOD:C1007("DBG_init";*)
	EXECUTE METHOD:C1007("DBG_mode_OnOff";*;True:C214)
	
	EXECUTE METHOD:C1007("DBG_module_Mode_Set";*;"http";True:C214)
	EXECUTE METHOD:C1007("DBG_module_Threshold_Set";*;"http";8)
	
	EXECUTE METHOD:C1007("DBG_logFileShow")
End if 
ARRAY TEXT:C222($tt_components;0)
