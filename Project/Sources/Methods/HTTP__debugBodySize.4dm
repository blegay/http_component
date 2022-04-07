//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : http__debugBodySize
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-sizeDebug-TEXT] : size debug
  //@parameter[1-IN-bodyPtr-POINTER] : body pointer (not modified)
  //@notes : 
  //@example : http__debugBodySize
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/10/2021, 12:56:59 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_sizeDebug)
C_POINTER:C301($1;$vp_bodyPtr)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
$vt_sizeDebug:=""
$vp_bodyPtr:=$1

C_LONGINT:C283($vl_bodyType)
$vl_bodyType:=Type:C295($vp_bodyPtr->)

Case of 
	: ($vl_bodyType=Is BLOB:K8:12)
		$vt_sizeDebug:="(blob) : "+HTTP__bytes (BLOB size:C605($vp_bodyPtr->);True:C214)
		
	: (($vl_bodyType=Is text:K8:3) | ($vl_bodyType=Is alpha field:K8:1))
		C_LONGINT:C283($vl_length)
		$vl_length:=Length:C16($vp_bodyPtr->)
		$vt_sizeDebug:="(text) : "+String:C10($vl_length;"# ### ### ##0")+" char"+Choose:C955($vl_length>1;"s";"")
		
	: ($vl_bodyType=Is object:K8:27)
		C_BLOB:C604($vx_jsonBlob)
		SET BLOB SIZE:C606($vx_jsonBlob;0)
		
		C_TEXT:C284($vt_json)
		$vt_json:=JSON Stringify:C1217($vp_bodyPtr->)
		TEXT TO BLOB:C554($vt_json;$vx_jsonBlob;UTF8 text without length:K22:17)
		$vt_json:=""
		
		$vt_sizeDebug:="(json) "+HTTP__bytes (BLOB size:C605($vx_jsonBlob);True:C214)
		
		SET BLOB SIZE:C606($vx_jsonBlob;0)
End case 

$0:=$vt_sizeDebug