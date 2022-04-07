//%attributes = {"shared":false,"invisible":true}

C_LONGINT:C283($vl_status)
C_TEXT:C284($vt_url;$vt_requestBody;$vt_responseBody)

If (True:C214)  // OK
	$vt_url:="https://test-api.service.hmrc.gov.uk/hello/world"
	$vt_requestBody:=""
	$vt_responseBody:=""
	ARRAY TEXT:C222($tt_headersKey;0)
	ARRAY TEXT:C222($tt_headersValue;0)
	APPEND TO ARRAY:C911($tt_headersKey;"Accept")
	APPEND TO ARRAY:C911($tt_headersValue;"application/vnd.hmrc.1.0+json")
	$vl_status:=HTTP Request:C1158(HTTP GET method:K71:1;$vt_url;$vt_requestBody;$vt_responseBody;$tt_headersKey;$tt_headersValue)
	
	ASSERT:C1129($vl_status=200)
	ASSERT:C1129($vt_responseBody="{\"message\":\"Hello World\"}")
	
	ALERT:C41(String:C10($vl_status)+"\r"+$vt_responseBody)
	
	  // curl \
				  --http1.1 \
				  --tlsv1.1 \
				  -H "Accept: application/vnd.hmrc.1.0+json" \
				  "https://test-api.service.hmrc.gov.uk/hello/world"
	
	  // {"message":"Hello World"}
	
End if 


  // b.legay@ac-consulting.fr
  // Ifooboo5Ree$6

  // app : test-ac (sandbox)
  // cliend_id : 7xYK88vnWSW4OtjPMwuzuub77Qfb
  // secret : 4bcb31b2-0aba-44b8-83b0-76bcf722d60b


  // test user login : 945220185073
  // test user password : igb5Twkp820o

If (False:C215)  // test 1 : OK
	
	$vt_url:="https://test-www.tax.service.gov.uk/oauth/authorize"
	
	C_OBJECT:C1216($vo_queryStringParameters)
	$vo_queryStringParameters:=New object:C1471
	$vo_queryStringParameters.response_type:="code"
	$vo_queryStringParameters.client_id:="7xYK88vnWSW4OtjPMwuzuub77Qfb"
	$vo_queryStringParameters.scope:="hello"
	$vo_queryStringParameters.state:=Generate UUID:C1066
	$vo_queryStringParameters.redirect_uri:="https://www.ac-consulting.fr"
	
	C_TEXT:C284($vt_url;$vt_queryString)
	$vt_queryString:=HTTP_queryStringStringify ($vo_queryStringParameters)
	$vt_url:=$vt_url+$vt_queryString
	SET TEXT TO PASTEBOARD:C523($vt_url)
	
	  // open this url in a browser and enter  test user login and test user password, it will redirect with query string with "code"
	  // https://test-www.tax.service.gov.uk/oauth/authorize?response_type=code&client_id=7xYK88vnWSW4OtjPMwuzuub77Qfb&scope=hello&state=7B22F79FED6544D9A6F09A9810C44282&redirect_uri=https%3A%2F%2Fwww.ac-consulting.fr
	
	  // => https://www.ac-consulting.fr/?code=dd29fadd118b4207a6b0641b75a99d28&state=4BBCC467701F42E293FC52E238804989
End if 

If (True:C214)  // test 2 : OK
	
	C_TEXT:C284($vt_url;$vt_requestBody;$vt_responseBody)
	$vt_url:="https://test-api.service.hmrc.gov.uk/oauth/token"
	
	C_OBJECT:C1216($vo_formParameters)
	$vo_formParameters:=New object:C1471
	$vo_formParameters.grant_type:="client_credentials"
	$vo_formParameters.client_secret:="4bcb31b2-0aba-44b8-83b0-76bcf722d60b"
	$vo_formParameters.client_id:="7xYK88vnWSW4OtjPMwuzuub77Qfb"
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
	
	ASSERT:C1129($vl_status=200)
	
	  // $vl_status : 200 
	  // $vt_responseBody : {"access_token":"b2915edf14c77c3c162c82cd72144954","scope":"hello","expires_in":14400,"token_type":"bearer"}
	
	ALERT:C41(String:C10($vl_status)+"\r"+$vt_responseBody)
	
End if 



