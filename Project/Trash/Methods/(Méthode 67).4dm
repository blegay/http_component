//%attributes = {"shared":false,"invisible":true}

C_OBJECT:C1216($vo_formParameters;$vo_token)

  // ok => parameters ok, I get a token
$vo_formParameters:=New object:C1471
$vo_formParameters.client_secret:="4bcb31b2-0aba-44b8-83b0-76bcf722d60b"
$vo_formParameters.client_id:="7xYK88vnWSW4OtjPMwuzuub77Qfb"
$vo_formParameters.scope:="hello"
$vo_token:=hmrc_oauthTokenGet ($vo_formParameters;True:C214)
ASSERT:C1129($vo_token.success;JSON Stringify:C1217($vo_token.error))
SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vo_token;*))

If ($vo_token.success)
	
	  // curl -X GET https://test-api.service.hmrc.gov.uk/hello/application \
		//  --http1.1 \
		//  --tlsv1.1 \
		//  -H "Accept: application/vnd.hmrc.1.0+json" \
		//  -H "Authorization: Bearer 5c9877b52346fc52e5bcdb00fb86b3a0"
	
	  // => {"message":"Hello Application"}
	
	C_TEXT:C284($vt_url;$vt_requestBody;$vt_responseBody)
	$vt_url:="https://test-api.service.hmrc.gov.uk/hello/application"
	
	ARRAY TEXT:C222($tt_headersKey;0)
	ARRAY TEXT:C222($tt_headersValue;0)
	APPEND TO ARRAY:C911($tt_headersKey;"Accept")
	APPEND TO ARRAY:C911($tt_headersValue;"application/vnd.hmrc.1.0+json")
	APPEND TO ARRAY:C911($tt_headersKey;"Authorization")
	APPEND TO ARRAY:C911($tt_headersValue;"Bearer "+$vo_token.token.access_token)  // "Bearer ..."
	
	C_LONGINT:C283($vl_status)
	$vl_status:=HTTP Request:C1158(HTTP GET method:K71:1;$vt_url;$vt_requestBody;$vt_responseBody;$tt_headersKey;$tt_headersValue)
	
	ASSERT:C1129($vl_status=200;"unexpected status : "+String:C10($vl_status)+" "+$vt_responseBody)
End if 

  // ko => wrong parameters
$vo_formParameters:=New object:C1471
$vo_formParameters.client_secret:="434341791131"
$vo_formParameters.client_id:="rbQe4c8jm12z"
$vo_formParameters.scope:="hello"  // read:vat write:vat"
$vo_token:=hmrc_oauthTokenGet ($vo_formParameters;True:C214)
ASSERT:C1129($vo_token.success;JSON Stringify:C1217($vo_token.error))
SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vo_token;*))






