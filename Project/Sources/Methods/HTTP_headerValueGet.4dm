//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_headerValueGet
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This function returns the header value for the given key
  //@parameter[0-OUT-headerValue-TEXT] : header value
  //@parameter[1-IN-headerCollection-COLLECTION] : header collection (not modified)
  //@parameter[2-IN-headerKey-TEXT] : header key
  //@notes : 
  //@example : HTTP_headerGetValue
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/10/2021, 14:36:41 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_headerValue)
C_COLLECTION:C1488($1;$c_collection)
C_TEXT:C284($2;$vt_headerKey)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")

$vt_headerValue:=""
$c_collection:=$1
$vt_headerKey:=$2

If ($c_collection#Null:C1517)
	$vt_headerKey:=Replace string:C233($vt_headerKey;":";"";*)
	
	If (Length:C16($vt_headerKey)>0)
		C_TEXT:C284($vt_regex)
		$vt_regex:="(?i)^"+$vt_headerKey+"\\s*:\\s*(.*)$"
		
		C_TEXT:C284($vt_headerLine)
		C_BOOLEAN:C305($vb_found)
		$vb_found:=False:C215
		For each ($vt_headerLine;$c_collection) Until ($vb_found)
			If (Length:C16($vt_headerLine)>0)
				ARRAY LONGINT:C221($tl_pos;0)
				ARRAY LONGINT:C221($tl_length;0)
				If (Match regex:C1019($vt_regex;$vt_headerLine;1;$tl_pos;$tl_length;*))
					$vt_headerValue:=Substring:C12($vt_headerLine;$tl_pos{1};$tl_length{1})
					$vb_found:=True:C214
				End if 
				ARRAY LONGINT:C221($tl_pos;0)
				ARRAY LONGINT:C221($tl_length;0)
			End if 
		End for each 
		
	End if 
End if 
$0:=$vt_headerValue

