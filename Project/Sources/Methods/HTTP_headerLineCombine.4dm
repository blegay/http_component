//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_headerLineCombine
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This function returns a http header line
  //@parameter[0-OUT-headerLine-TEXT] : http header line
  //@parameter[1-IN-headerKey-TEXT] : http header key
  //@parameter[2-IN-headerValue-TEXT] : http header value
  //@notes : 
  //@example : 
  // C_LONGINT($i)
  //  For ($i;1;Size of array($tt_headerKeys)
  //   $vo_httpObject.response.headers.push(HTTP_headerLineCombine ($tt_headerKeys{$i};$tt_headerValues{$i}))
  //  End for 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/10/2021, 12:26:02 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_headerLine)
C_TEXT:C284($1;$vt_headerKey)
C_TEXT:C284($2;$vt_headerValue)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")

$vt_headerLine:=""
$vt_headerKey:=$1
$vt_headerValue:=$2

$vt_headerKey:=http__headerKeyClean ($vt_headerKey)
$vt_headerValue:=http__headerValueClean ($vt_headerValue)

C_LONGINT:C283($vl_pos)
$vl_pos:=Position:C15(":";$vt_headerKey;*)
If ($vl_pos>0)
	$vt_headerKey:=Substring:C12($vt_headerKey;1;$vl_pos-1)
End if 

If (Length:C16($vt_headerKey)>0)
	
	If (Length:C16($vt_headerValue)>0)
		$vt_headerLine:=$vt_headerKey+": "+$vt_headerValue
	Else 
		$vt_headerLine:=$vt_headerKey+":"
	End if 
End if 

$0:=$vt_headerLine