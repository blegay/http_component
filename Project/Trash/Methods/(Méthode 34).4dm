//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : Méthode 34
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
  //@example : Méthode 34
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/10/2021, 12:18:12 - 1.00.00
  //@xdoc-end
  //================================================================================


C_OBJECT:C1216($vo_httpObject)
$vo_httpObject:=HTTP_requestNew (HTTP GET method:K71:1;"https://www.rfc-editor.org/rfc/rfc1.txt")

  //$vo_httpObject.request.headers.push("Accept-Encoding: gzip, deflate")
  //HTTP_headerValueSet ($vo_httpObject.request.headers;"Accept-Encoding";"gzip, deflate")
HTTP_headerValueSet ($vo_httpObject.request.headers;"accept-encoding";"gzip")

$vo_httpObject.keepAlive:=False:C215

C_TEXT:C284($vt_requestBody;$vt_responseBody)
If (HTTP_requestCall ($vo_httpObject;->$vt_requestBody;->$vt_responseBody))
	If ($vo_httpObject.status=200)
		
		Case of 
			: (HTTP_headerValueGet ($vo_httpObject.response.headers;"Content-Type")="text/plain@")  // "Content-Type: text/plain; charset=utf-8"
				
		End case 
		
		
	End if 
End if 

