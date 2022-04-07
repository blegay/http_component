//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : http__headerValueClean
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@parameter[1-IN-paramName-OBJECT] : ParamDescription
  //@parameter[2-IN-paramName-POINTER] : ParamDescription (not modified)
  //@parameter[3-INOUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[4-OUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[5-IN-paramName-LONGINT] : ParamDescription (optional, default value : 1)
  //@notes : 
  //@example : http__headerValueClean
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/10/2021, 15:39:48 - 1.00.00
  //@xdoc-end
  //================================================================================
C_TEXT:C284($0;$vt_out)
C_TEXT:C284($1;$vt_in)

$vt_out:=""
$vt_in:=$1

$vt_out:=Replace string:C233($vt_in;"\r";"";*)
$vt_out:=Replace string:C233($vt_out;"\n";"";*)
$vt_out:=TXT_trimWhiteSpaces ($vt_out)

$0:=$vt_out