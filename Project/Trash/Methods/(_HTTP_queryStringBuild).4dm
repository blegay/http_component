//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_queryStringBuild
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This function build a query string from a list of query string elements
  //@parameter[0-OUT-queryString-TEXT] : query string
  //@parameter[$1-IN-queryStringCollection-COLLECTION] : query string elements
  //@notes : 
  //@example : 

  //C_COLLECTION($c_test)
  //$c_test:=New collection(\
New object("param";"param1";"value";"value1");\
New object("param";"param2";"value";"value2"))

  //ASSERT(HTTP_queryStringBuild ($c_test)="?param1=value1&param2=value2")

  //C_COLLECTION($c_test)
  //$c_test:=New collection(\
New object("param";"param1";"value";"value1 /=+");\
New object("param";"param2";"value";"été?&"))

  //ASSERT(HTTP_queryStringBuild ($c_test)="?param1=value1+%2F%3D%2B&param2=%C3%A9t%C3%A9%3F%26")

  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/10/2021, 15:58:28 - 0.00.05
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_queryString)
C_COLLECTION:C1488($1;$c_queryStringElements)

$vt_queryString:=""
If (Count parameters:C259>0)
	$c_queryStringElements:=$1
	If ($c_queryStringElements#Null:C1517)
		If ($c_queryStringElements.length>0)
			
			C_BOOLEAN:C305($vb_encodeSlash;$vb_encodeSpaceAsPlus)
			$vb_encodeSlash:=True:C214
			$vb_encodeSpaceAsPlus:=False:C215
			
			C_LONGINT:C283($vl_paramIndex)
			$vl_paramIndex:=1
			C_OBJECT:C1216($vo_queryString)
			For each ($vo_queryString;$c_queryStringElements)
				
				C_TEXT:C284($vt_param;$vt_value)
				$vt_param:=String:C10($vo_queryString.param)
				$vt_value:=String:C10($vo_queryString.value)
				
				If (Length:C16($vt_param)>0)
					
					C_TEXT:C284($vt_paramValue)
					If (Length:C16($vt_value)>0)
						$vt_paramValue:=HTTP_urlEncode ($vt_param;$vb_encodeSlash;$vb_encodeSpaceAsPlus)+"="+HTTP_urlEncode ($vt_value;$vb_encodeSlash;$vb_encodeSpaceAsPlus)
					Else 
						$vt_paramValue:=HTTP_urlEncode ($vt_param;$vb_encodeSlash;$vb_encodeSpaceAsPlus)
					End if 
					
					$vt_queryString:=$vt_queryString+Choose:C955($vl_paramIndex=1;"?";"&")+$vt_paramValue
					
					$vl_paramIndex:=$vl_paramIndex+1
				End if 
			End for each 
			
		End if 
	End if 
	
End if 
$0:=$vt_queryString