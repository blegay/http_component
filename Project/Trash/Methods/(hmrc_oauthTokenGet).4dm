//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : hmrc_oauthTokenGet
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-result-OBJECT] : result object
  //@parameter[1-IN-formParameters-OBJECT] : formParameters ("client_secret", "client_id", "scope")
  //@parameter[2-IN-useTest-BOOLEAN] : if true uses test-api (optional, default value : FALSE)
  //@notes : 

  //   $vo_formParameters.client_secret:="xxxx"
  //   $vo_formParameters.client_id:="yyyyyy"
  //   $vo_formParameters.scope:="hello"


  //@example : hmrc_oauthTokenGet

  // {
  //     "success": true,
  //     "token": {
  //         "access_token": "fa4ccb0ea6056fc9ea7ee299e4155bba",
  //         "scope": "hello",
  //         "expires_in": 14400,
  //         "token_type": "bearer"
  //     },
  //     "error": null
  // }
  // 
  // {
  //     "success": false,
  //     "token": null,
  //     "error": {
  //         "error": "invalid_client",
  //         "error_description": "invalid client id or secret"
  //     }
  // }
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 31/03/2022, 11:39:47 - 0.00.05
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_result)
C_OBJECT:C1216($1;$vo_formParameters)
C_BOOLEAN:C305($2;$vb_useTest)

$vo_formParameters:=OB Copy:C1225($1)
  //$vo_formParameters:=$1.copy()

If (Count parameters:C259>1)
	$vb_useTest:=$2
Else 
	$vb_useTest:=False:C215
End if 

C_TEXT:C284($vt_url;$vt_requestBody;$vt_responseBody)

If ($vb_useTest)
	$vt_url:="https://test-api.service.hmrc.gov.uk/oauth/token"
Else 
	$vt_url:="https://api.service.hmrc.gov.uk/oauth/token"
End if 

$vo_formParameters.grant_type:="client_credentials"

$vt_requestBody:=HTTP_wwwFormUrlStringify ($vo_formParameters)
$vt_responseBody:=""



C_OBJECT:C1216($vo_httpObject)
$vo_httpObject:=HTTP_requestNew (HTTP POST method:K71:2;$vt_url)

HTTP_headerValueSet ($vo_httpObject.request.headers;"Content-Type";"application/x-www-form-urlencoded")
HTTP_headerValueSet ($vo_httpObject.request.headers;"Accept";"application/json")

$vo_result:=New object:C1471("success";Null:C1517;"token";Null:C1517;"error";Null:C1517)

C_TEXT:C284($vt_requestBody;$vt_responseBody)
If (HTTP_requestCall ($vo_httpObject;->$vt_requestBody;->$vt_responseBody))
	
	$vo_result.success:=($vo_httpObject.status=200)
	
	Case of 
		: (HTTP_headerValueGet ($vo_httpObject.response.headers;"Content-Type")="application/json")
			
			If ($vo_httpObject.status=200)
				$vo_result.token:=JSON Parse:C1218($vt_responseBody)
			Else 
				$vo_result.error:=JSON Parse:C1218($vt_responseBody)
			End if 
			
	End case 
	
End if 




  //ARRAY TEXT($tt_headersKey;0)
  //ARRAY TEXT($tt_headersValue;0)
  //APPEND TO ARRAY($tt_headersKey;"Content-Type")
  //APPEND TO ARRAY($tt_headersValue;"application/x-www-form-urlencoded")
  //APPEND TO ARRAY($tt_headersKey;"Accept")
  //APPEND TO ARRAY($tt_headersValue;"application/json")

  //C_LONGINT($vl_status)
  //$vl_status:=HTTP Request(HTTP POST method;$vt_url;$vt_requestBody;$vt_responseBody;$tt_headersKey;$tt_headersValue)

  //$vo_result:=New object("success";Null;"token";Null;"error";Null)
  //$vo_result.success:=($vl_status=200)
  //If ($vl_status=200)
  //$vo_result.token:=JSON Parse($vt_responseBody)
  //Else 
  //$vo_result.error:=JSON Parse($vt_responseBody)
  //End if 

$0:=$vo_result
