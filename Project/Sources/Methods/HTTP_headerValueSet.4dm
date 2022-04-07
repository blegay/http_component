//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_headerValueSet
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This function sets the header value for the given key
  //@parameter[1-IN-headerCollection-COLLECTION] : header collection (modified)
  //@parameter[2-IN-headerKey-TEXT] : header key
  //@parameter[3-IN-headerValue-TEXT] : header value
  //@notes : 
  //@example : HTTP_headerValueSet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/10/2021, 14:53:39 - 1.00.00
  //@xdoc-end
  //================================================================================

C_COLLECTION:C1488($1;$c_collection)
C_TEXT:C284($2;$vt_headerKey)
C_TEXT:C284($3;$vt_headerValue)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")

$c_collection:=$1
$vt_headerKey:=$2
$vt_headerValue:=$3

If ($c_collection#Null:C1517)
	$vt_headerKey:=Replace string:C233($vt_headerKey;":";"";*)
	
	
	If (Length:C16($vt_headerKey)>0)
		C_TEXT:C284($vt_headerLineNew)
		$vt_headerLineNew:=HTTP_headerLineCombine ($vt_headerKey;$vt_headerValue)
		
		C_TEXT:C284($vt_regex)
		$vt_regex:="(?i)^"+$vt_headerKey+"\\s*:\\s*(.*)$"
		
		C_BOOLEAN:C305($vb_found)
		$vb_found:=False:C215
		C_LONGINT:C283($vl_index)
		$vl_index:=0
		C_TEXT:C284($vt_headerLine)
		For each ($vt_headerLine;$c_collection) Until ($vb_found)
			If (Length:C16($vt_headerLine)>0)
				ARRAY LONGINT:C221($tl_pos;0)
				ARRAY LONGINT:C221($tl_length;0)
				If (Match regex:C1019($vt_regex;$vt_headerLine;1;$tl_pos;$tl_length;*))
					$c_collection[$vl_index]:=$vt_headerLineNew
					$vb_found:=True:C214
				End if 
				ARRAY LONGINT:C221($tl_pos;0)
				ARRAY LONGINT:C221($tl_length;0)
			End if 
			$vl_index:=$vl_index+1
		End for each 
		If (Not:C34($vb_found))
			$c_collection.push($vt_headerLineNew)
		End if 
		
	End if 
End if 

