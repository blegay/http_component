//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_wwwFormUrlStringify
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This function build a text for a form "application/x-www-form-urlencoded" encoding
  //@parameter[0-OUT-queryString-TEXT] : query string
  //@parameter[$1-IN-object-OBJECT] : query string object
  //@notes : 
  //@example : 
  // C_OBJECT($vo_formParameters)
  // $vo_formParameters:=New Object
  // $vo_formParameters.param1:="value1"
  // $vo_formParameters.param2:="value2"
  //
  // ASSERT(HTTP_wwwFormUrlStringify ($vo_formParameters)="param1=value1&param2=value2")

  // C_OBJECT($vo_formParameters)
  // $vo_formParameters:=New Object
  // $vo_formParameters.param1:="value1 /=+"
  // $vo_formParameters.param2:="été?&"
  //
  //ASSERT(HTTP_wwwFormUrlStringify ($vo_formParameters)="param1=value1+%2F%3D%2B&param2=%C3%A9t%C3%A9%3F%26")

  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 28/10/2021, 10:17:01 - 0.00.05
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_queryString)
C_OBJECT:C1216($1;$vo_formParameters)

$vt_queryString:=""
If (Count parameters:C259>0)
	$vo_formParameters:=$1
	If ($vo_formParameters#Null:C1517)
		  //If ($vo_formParameters.length>0)
		
		C_BOOLEAN:C305($vb_encodeSlash;$vb_encodeSpaceAsPlus)
		$vb_encodeSlash:=True:C214
		$vb_encodeSpaceAsPlus:=False:C215
		
		C_TEXT:C284($vt_propertyName)
		For each ($vt_propertyName;$vo_formParameters)
			
			C_LONGINT:C283($vl_propertyType)
			$vl_propertyType:=OB Get type:C1230($vo_formParameters;$vt_propertyName)
			
			C_TEXT:C284($vt_value)
			
			C_BOOLEAN:C305($vb_canStringify)
			$vb_canStringify:=True:C214
			Case of 
				: ($vl_propertyType=Is text:K8:3)
					  //$vb_canStringify:=True
					$vt_value:=$vo_formParameters[$vt_propertyName]
					
				: ($vl_propertyType=Is date:K8:7)
					  //$vb_canStringify:=True
					C_DATE:C307($vd_date)
					$vd_date:=$vo_formParameters[$vt_propertyName]
					
					$vt_value:=\
						String:C10(Year of:C25($vd_date);"0000")+"-"+\
						String:C10(Month of:C24($vd_date);"00")+"-"+\
						String:C10(Day of:C23($vd_date);"00")
					
				: ($vl_propertyType=Is real:K8:4)
					  //$vb_canStringify:=True
					$vt_value:=String:C10($vo_formParameters[$vt_propertyName];"&xml")
					
				: ($vl_propertyType=Is boolean:K8:9)
					  //$vb_canStringify:=True
					$vt_value:=Choose:C955($vo_formParameters[$vt_propertyName];"true";"false")
					
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
				
				$vt_queryString:=$vt_queryString+Choose:C955(Length:C16($vt_queryString)=0;"";"&")+$vt_paramValue
				
			End if 
			$vt_value:=""
		End for each 
		
		  //End if 
	End if 
	
End if 
$0:=$vt_queryString