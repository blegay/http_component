//%attributes = {"invisible":true,"preemptive":"capable","shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : HEX_byteToHexStr
  //@scope : public
  //@deprecated : no
  //@description : This function returns a 0xFF bit mask 
  //@parameter[0-OUT-hex-ALPHA 2] : byte in hex format : "00" .. "FF"
  //@parameter[1-IN-byte-LONGINT] : byte
  //@notes : a 0xFF bit mask is applied
  //@example : HEX_byteToHexStr (233) ==> "E9"
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 03/07/2014, 19:54:37 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_hex)
C_LONGINT:C283($1;$vl_byte)
$vt_hex:="00"
If (Count parameters:C259>0)
	$vl_byte:=$1
	
	$vl_byte:=($vl_byte & 0x00FF)
	
	  // "0x0000"
	$vt_hex:=Substring:C12(String:C10($vl_byte;"&x");5)
End if 
$0:=$vt_hex