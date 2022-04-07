//%attributes = {"shared":false,"invisible":true}

If (True:C214)
	
	C_TEXT:C284($vt_url;$vt_requestBody;$vt_responseBody)
	$vt_url:="https://test-api.service.hmrc.gov.uk/oauth/token"
	
	C_OBJECT:C1216($vo_formParameters)
	$vo_formParameters:=New object:C1471
	$vo_formParameters.grant_type:="client_credentials"
	$vo_formParameters.client_secret:="434341791131"  //"4bcb31b2-0aba-44b8-83b0-76bcf722d60b"
	$vo_formParameters.client_id:="rbQe4c8jm12z"  // "7xYK88vnWSW4OtjPMwuzuub77Qfb"
	$vo_formParameters.scope:="hello"
	
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vo_formParameters))
	
	$vt_requestBody:=HTTP_wwwFormUrlStringify ($vo_formParameters)
	  //ALERT($vt_requestBody)
	
	ARRAY TEXT:C222($tt_headersKey;0)
	ARRAY TEXT:C222($tt_headersValue;0)
	APPEND TO ARRAY:C911($tt_headersKey;"Content-Type")
	APPEND TO ARRAY:C911($tt_headersValue;"application/x-www-form-urlencoded")
	APPEND TO ARRAY:C911($tt_headersKey;"Accept")
	APPEND TO ARRAY:C911($tt_headersValue;"application/json")
	
	  // url : https://test-api.service.hmrc.gov.uk/oauth/token
	  // request body : grant_type=client_credentials&client_secret=4bcb31b2-0aba-44b8-83b0-76bcf722d60b&client_id=7xYK88vnWSW4OtjPMwuzuub77Qfb&scope=hello
	
	  // test with curl : ok
	  // curl \
		  --http1.1 \
		  --tlsv1.1 \
		  -H "Accept: application/json" \
		  -H "Content-Type: application/x-www-form-urlencoded" \
		  -X POST \
		  -d "grant_type=client_credentials&client_secret=4bcb31b2-0aba-44b8-83b0-76bcf722d60b&client_id=7xYK88vnWSW4OtjPMwuzuub77Qfb&scope=hello" \
		  https://test-api.service.hmrc.gov.uk/oauth/token
	  // {"access_token":"222faf222bb88783f9bd35442d003e36","scope":"hello","expires_in":14400,"token_type":"bearer"}
	
	  // test with 4D : ok
	C_LONGINT:C283($vl_status)
	$vl_status:=HTTP Request:C1158(HTTP POST method:K71:2;$vt_url;$vt_requestBody;$vt_responseBody;$tt_headersKey;$tt_headersValue)
	
	  // {"error":"invalid_client","error_description":"invalid client id or secret"}
	
End if 