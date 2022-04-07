//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_queryStringStringify
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This function build a query string from a list of query string elements
  //@parameter[0-OUT-queryString-TEXT] : query string
  //@parameter[$1-IN-object-OBJECT] : query string object
  //@notes : 
  //@example : 

  // C_OBJECT($vo_queryStringParameters)
  // $vo_queryStringParameters:=New Object
  // $vo_queryStringParameters.param1:="value1"
  // $vo_queryStringParameters.param2:="value2"
  //
  // ASSERT(HTTP_queryStringStringify ($vo_queryStringParameters)="?param1=value1&param2=value2")

  // C_OBJECT($vo_queryStringParameters)
  // $vo_queryStringParameters:=New Object
  // $vo_queryStringParameters.param1:="value1 /=+"
  // $vo_queryStringParameters.param2:="été?&"
  //
  //ASSERT(HTTP_queryStringStringify ($vo_queryStringParameters)="?param1=value1+%2F%3D%2B&param2=%C3%A9t%C3%A9%3F%26")

  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/10/2021, 15:58:28 - 0.00.05
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_queryString)
C_OBJECT:C1216($1;$vo_queryStringParameters)

$vt_queryString:=""
If (Count parameters:C259>0)
	$vo_queryStringParameters:=$1
	If ($vo_queryStringParameters#Null:C1517)
		  //If ($vo_queryStringParameters.length>0)
		
		C_BOOLEAN:C305($vb_encodeSlash;$vb_encodeSpaceAsPlus)
		$vb_encodeSlash:=True:C214
		$vb_encodeSpaceAsPlus:=False:C215
		
		C_LONGINT:C283($vl_paramIndex)
		$vl_paramIndex:=1
		C_TEXT:C284($vt_propertyName)
		For each ($vt_propertyName;$vo_queryStringParameters)
			
			C_LONGINT:C283($vl_propertyType)
			$vl_propertyType:=OB Get type:C1230($vo_queryStringParameters;$vt_propertyName)
			
			C_TEXT:C284($vt_value)
			
			C_BOOLEAN:C305($vb_canStringify)
			$vb_canStringify:=True:C214
			Case of 
				: ($vl_propertyType=Is text:K8:3)
					  //$vb_canStringify:=True
					$vt_value:=$vo_queryStringParameters[$vt_propertyName]
					
				: ($vl_propertyType=Is date:K8:7)
					  //$vb_canStringify:=True
					C_DATE:C307($vd_date)
					$vd_date:=$vo_queryStringParameters[$vt_propertyName]
					
					$vt_value:=\
						String:C10(Year of:C25($vd_date);"0000")+"-"+\
						String:C10(Month of:C24($vd_date);"00")+"-"+\
						String:C10(Day of:C23($vd_date);"00")
					
				: ($vl_propertyType=Is real:K8:4)
					  //$vb_canStringify:=True
					$vt_value:=String:C10($vo_queryStringParameters[$vt_propertyName];"&xml")
					
				: ($vl_propertyType=Is boolean:K8:9)
					  //$vb_canStringify:=True
					$vt_value:=Choose:C955($vo_queryStringParameters[$vt_propertyName];"true";"false")
					
				: ($vl_propertyType=Is null:K8:31)
					  //$vb_canStringify:=True
					$vt_value:=""
					
				Else 
					$vb_canStringify:=False:C215
					  //: ($vl_propertyType=Is undefined)
					  //: ($vl_propertyType=Is object)
					  //: ($vl_propertyType=Is collection)
			End case 
			
			
			If ($vb_canStringify)
				
				C_TEXT:C284($vt_paramValue)
				If (Length:C16($vt_value)>0)
					$vt_paramValue:=HTTP_urlEncode ($vt_propertyName;$vb_encodeSlash;$vb_encodeSpaceAsPlus)+"="+HTTP_urlEncode ($vt_value;$vb_encodeSlash;$vb_encodeSpaceAsPlus)
				Else 
					$vt_paramValue:=HTTP_urlEncode ($vt_propertyName;$vb_encodeSlash;$vb_encodeSpaceAsPlus)
				End if 
				
				$vt_queryString:=$vt_queryString+Choose:C955($vl_paramIndex=1;"?";"&")+$vt_paramValue
				
				$vl_paramIndex:=$vl_paramIndex+1
				
			End if 
			$vt_value:=""
		End for each 
		
		  //End if 
	End if 
	
End if 
$0:=$vt_queryString