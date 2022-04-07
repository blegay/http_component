//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_queryStringToObj
  //@scope : public
  //@deprecated : no
  //@description : This function converts a query string to an object
  //@parameter[0-OUT-$vt_canonicalQueryStringObject-OBJET] : canonical query string object
  //@parameter[1-IN-$vt_canonicalQueryString-TEXT] : canonical query string (e.g. "X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Expires=86400&X-Amz-SignedHeaders=host")
  //@notes : 
  //@example : HTTP_canonicalQueryStringToObj
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 06/05/2019, 11:20:43 - 3.00.00
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_object)
C_TEXT:C284($1;$vt_canonicalQueryString)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vo_object:=New object:C1471

$vt_canonicalQueryString:=$1
If (Length:C16($vt_canonicalQueryString)>0)
	
	C_COLLECTION:C1488($c_queryStringElements)
	$c_queryStringElements:=New collection:C1472
	$c_queryStringElements:=Split string:C1554($vt_canonicalQueryString;"&")
	
	C_TEXT:C284($vt_queryStringElement)
	For each ($vt_queryStringElement;$c_queryStringElements)
		
		C_LONGINT:C283($vl_position)
		$vl_position:=Position:C15("=";$vt_queryStringElement;*)
		
		C_TEXT:C284($vt_key;$vt_value)
		If ($vl_position>0)
			$vt_key:=HTTP_urlDecode (Substring:C12($vt_queryStringElement;1;$vl_position-1))
			$vt_value:=HTTP_urlDecode (Substring:C12($vt_queryStringElement;$vl_position+1))
			$vo_object[$vt_key]:=$vt_value
		Else 
			$vt_key:=HTTP_urlDecode ($vt_queryStringElement)
			$vo_object[$vt_key]:=Null:C1517
		End if 
		
	End for each 
	
End if 

$0:=$vo_object